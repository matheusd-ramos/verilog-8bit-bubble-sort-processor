module ULA(
    input [7:0] r1,      // Entrada R1
    input [7:0] r2,      // Entrada R2
    input ALUOp,         // Sinal de controle (0 para soma, 1 para subtração)
    output reg [7:0] resultado, // Saída de 8 bits do resultado
    output reg lt        // Saida para "set on less than"
);

always @(*) begin

    if (ALUOp == 0) begin
        resultado = r1 + r2;
    end else begin
        resultado = r1 - r2;
    end

    // lt=1 quando r1 > r2 ("maior"); usado pelo JUMP junto com o bit cond (1=maior, 0=menor)
    if (r1 > r2) begin
        lt = 1;
    end else begin
        lt = 0;
    end
end

endmodule