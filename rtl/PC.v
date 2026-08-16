module PC (HALT, pc, pcNovo, CLOCK);

input HALT;
input CLOCK;
input [7:0] pcNovo;
output reg [7:0] pc;

// Inicialização do PC (Endereço de insturuções começa em 0)
initial begin
    pc = 8'b00001000;
end

always @(posedge CLOCK) begin
    if (!HALT) begin
        pc <= pcNovo;
    end
end

endmodule