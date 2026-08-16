module controle(instrucao, MemToReg, LeMem, EscMem, ALUOp, Jump, ALUSrc, EscReg1, EscReg2, Halt, DestR2, EscFlag);

input [7:0] instrucao;
output reg ALUOp, Jump, LeMem, EscMem, ALUSrc, EscReg1, EscReg2, Halt, DestR2, EscFlag;
output reg [1:0] MemToReg;

// MemToReg seleciona o dado escrito no banco de registradores (mux_dado em processador.v):
//   00 = resultadoULA   (usado por CMP, embora CMP nao escreva registrador)
//   01 = saidaExtensor  (LOADI)
//   10 = resultadoULA   (INC/DEC)
//   11 = dadoMem        (LOAD)

always @(instrucao) begin
    // Valores padrão
    MemToReg = 2'b00;
    LeMem = 0;
    EscMem = 0;
    ALUOp = 0;
    Jump = 0;
    ALUSrc = 0;
    EscReg1 = 0;
    EscReg2 = 0;
    Halt = 0;
    DestR2 = 0; // por padrao, registrador de escrita = R1
    EscFlag = 0;

    case (instrucao[7:5]) 
        3'b000: begin // STORE: mem[R1] = R2 (endereco em R1, dado em R2)
            EscMem = 1;
        end
        
        3'b001: begin // LOAD: R2 = mem[R1] (endereco em R1, destino em R2)
            LeMem = 1;
            MemToReg = 2'b11;
            EscReg2 = 1;
            DestR2 = 1; // destino da escrita e' R2, nao R1
        end
        
        3'b010: begin // LOADI: R1 = imediato
            MemToReg = 2'b01;
            EscReg2 = 1;
        end
        
        3'b011: begin // JUMP
           Jump = 1;
        end

        3'b100: begin // INC (funct=1) ou DEC (funct=0), destino = R1
            ALUOp = instrucao[0] ? 0 : 1; // 1=INC(soma) -> ALUOp=0 ; 0=DEC(subtracao) -> ALUOp=1
            MemToReg = 2'b10;
            ALUSrc = 1;
            EscReg2 = 1;
        end

        3'b101: begin // CMP: compara R1 com R2 (nao escreve registrador)
           ALUOp = 1;
              EscFlag = 1;
        end

        3'b110: begin // SWAP: troca R1 e R2
           EscReg1 = 1;
           EscReg2 = 1;
        end

        3'b111: begin // HALT
           Halt = 1;
        end

    endcase
end

endmodule