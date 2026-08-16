module processador(CLOCK);

input CLOCK;

// Sinais internos do processador
wire [7:0] pc, pcNovo, pcMais1, instrucao;
wire [7:0] S1, S2, resultadoULA, saidaExtensor, dadoMem, saidaMux;
wire [1:0] R1, R2, MemToReg, regEscrita;
wire ALUOp, Jump, LeMem, EscMem, ALUSrc, EscReg1, EscReg2, Halt, DestR2, EscFlag;
wire lt, saiFlag;

// Identifica o tipo de instrução (para os muxes de decodificação)
wire isLoadi   = (instrucao[7:5] == 3'b010);
wire isIncDec  = (instrucao[7:5] == 3'b100);
wire isJump    = (instrucao[7:5] == 3'b011);

// Decodificação dos campos de registrador
// Para a maioria das instruções: R1 = instrucao[4:3], R2 = instrucao[2:1]
// Para JUMP: op1 é fixo (00), o registrador-alvo do salto fica em instrucao[1:0]
//            e o bit de condição fica em instrucao[2]
assign R1 = instrucao[4:3];
assign R2 = isJump ? instrucao[1:0] : instrucao[2:1];
wire   condJump = instrucao[2];

// Índice do registrador de escrita: LOAD escreve em R2, as demais em R1
assign regEscrita = DestR2 ? R2 : R1;

// Extensor para LOADI (imediato 3 bits para 8 bits)
extensor extensor_modulo(
    .in(instrucao[2:0]),
    .out(saidaExtensor)
);

// Entrada 1 da ULA
wire [7:0] entradaULA1 = S1;

// Entrada 2 da ULA (S2, ou o imediato correto para LOADI/INC/DEC)
wire [7:0] imediatoIncDec = {6'b0, instrucao[2:1]};
wire [7:0] imediatoLoadi  = {5'b0, instrucao[2:0]};
wire [7:0] entradaULA2 = isLoadi  ? imediatoLoadi :
                         isIncDec ? imediatoIncDec :
                         S2;

// Mux para dado de escrita no banco de registradores
// sel=00 (resultadoULA, não usado p/ escrita atualmente) | sel=01 LOADI | sel=10 INC/DEC | sel=11 LOAD (memória)
mux mux_dado(
    .in1(resultadoULA),
    .in2(saidaExtensor),
    .in3(resultadoULA),
    .in4(dadoMem),
    .out(saidaMux),
    .sel(MemToReg)
);

// Registrador de flag (resultado da última CMP), amostrado na borda de subida
regFlag regFlag_modulo(
    .CLOCK(CLOCK),
    .escFlag(EscFlag),
    .flag(lt),
    .saiFlag(saiFlag)
);

// Cálculo do próximo PC: pc+1, ou o valor do registrador-alvo se o JUMP for tomado
assign pcMais1 = pc + 8'd1;
wire tomaJump = Jump && (saiFlag == condJump);
assign pcNovo = tomaJump ? S2 : pcMais1;

// Instanciação dos módulos principais
PC pc_modulo(.HALT(Halt), .pc(pc), .pcNovo(pcNovo), .CLOCK(CLOCK));

memInst memInst_modulo(.endereco(pc), .inst(instrucao), .CLOCK(CLOCK));

controle controle_modulo(.instrucao(instrucao), .MemToReg(MemToReg), .LeMem(LeMem), 
                       .EscMem(EscMem), .ALUOp(ALUOp), .Jump(Jump), .ALUSrc(ALUSrc), 
                       .EscReg1(EscReg1), .EscReg2(EscReg2), .Halt(Halt), .DestR2(DestR2),
                       .EscFlag(EscFlag));

bancoDeRegs bancoRegs_modulo(
    .R1(R1), .R2(R2), .RegEscrita(regEscrita), .dado(saidaMux), .escReg1(EscReg1),
    .escReg2(EscReg2), .S1(S1), .S2(S2), .CLOCK(CLOCK)
);

ULA ula_modulo(.r1(entradaULA1), .r2(entradaULA2), .ALUOp(ALUOp), 
               .resultado(resultadoULA), .lt(lt));

// Endereço de memória vem de R1 (registrador de endereço), dado a escrever vem de R2
memDados memDados_modulo(.endReg(S1), .escMem(EscMem), .leMem(LeMem), 
                        .escDado(S2), .saiDado(dadoMem), .CLOCK(CLOCK));

endmodule