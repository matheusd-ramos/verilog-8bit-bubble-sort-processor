module bancoDeRegs(R1, R2, RegEscrita, dado, escReg1, escReg2, S1, S2, CLOCK);

input CLOCK;
input [7:0] dado;
input escReg1, escReg2;
input [1:0] R1, R2, RegEscrita; // RegEscrita = indice do registrador destino na escrita simples (LOAD usa R2, os demais usam R1)

output reg [7:0] S1, S2; // combinacionais (dependem de R1/R2, nao de clock)

reg [7:0] r0, r1, r2, r3;
reg [7:0] temp1, temp2;

initial begin
    r0 = 8'b0;
    r1 = 8'b0;
    r2 = 8'b0;
    r3 = 8'b0;
    temp1 = 8'b0;
    temp2 = 8'b0;
end

// Borda de subida para escrita
always@(posedge CLOCK) begin
    // Troca de valores entre registradores (SWAP)
    if(escReg1 && escReg2) begin
        // Salva os valores atuais em temporários
        case (R1)
            2'b00: temp1 = r0;
            2'b01: temp1 = r1;
            2'b10: temp1 = r2;
            2'b11: temp1 = r3;
        endcase
        case (R2)
            2'b00: temp2 = r0;
            2'b01: temp2 = r1;
            2'b10: temp2 = r2;
            2'b11: temp2 = r3;
        endcase
        // Realiza a troca usando os temporários
        case (R1)
            2'b00: r0 <= temp2;
            2'b01: r1 <= temp2;
            2'b10: r2 <= temp2;
            2'b11: r3 <= temp2;
        endcase
        case (R2)
            2'b00: r0 <= temp1;
            2'b01: r1 <= temp1;
            2'b10: r2 <= temp1;
            2'b11: r3 <= temp1;
        endcase
    end
    // Escrita padrão: usa RegEscrita (R1 na maioria das instrucoes, R2 no LOAD)
    else if(escReg2) begin
        case (RegEscrita)
            2'b00: begin r0 <= dado; $display("[BancoDeRegs] Escrevendo r0 = %d", dado); end
            2'b01: begin r1 <= dado; $display("[BancoDeRegs] Escrevendo r1 = %d", dado); end
            2'b10: begin r2 <= dado; $display("[BancoDeRegs] Escrevendo r2 = %d", dado); end
            2'b11: begin r3 <= dado; $display("[BancoDeRegs] Escrevendo r3 = %d", dado); end
        endcase
    end
end

// Leitura combinacional (precisa refletir R1/R2 da instrucao atual dentro do mesmo ciclo)
always@(*) begin
    case (R1)
        2'b00: S1 = r0;
        2'b01: S1 = r1;
        2'b10: S1 = r2;
        2'b11: S1 = r3;
    endcase

    case (R2)
        2'b00: S2 = r0;
        2'b01: S2 = r1;
        2'b10: S2 = r2;
        2'b11: S2 = r3;
    endcase
end

endmodule