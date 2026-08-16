module memDados(endReg, escMem, leMem, escDado, saiDado, CLOCK);

input CLOCK, escMem, leMem;
input [7:0] endReg, escDado;
output [7:0] saiDado; // combinacional

// Declaração da memória de dados (128 posições de 8 bits)
reg [7:0] mem [0:255];

initial begin
    mem[0] = 8'b00000011;
    mem[1] = 8'b00000001;
    mem[2] = 8'b00000100;
    mem[3] = 8'b00000010;
    // Zera o resto da memória
    for(integer i = 4; i < 256; i++) begin
        mem[i] = 8'b00000000;
    end
end

// Lógica de escrita
always @(posedge CLOCK) begin
    if(escMem) begin
        mem[endReg] <= escDado;
    end 
end

// Leitura combinacional (o dado precisa estar pronto no mesmo ciclo pra chegar no mux de escrita do LOAD)
assign saiDado = mem[endReg];

endmodule