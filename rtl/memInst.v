module memInst(endereco, inst, CLOCK);

input CLOCK;
input [7:0] endereco;
output [7:0] inst;

// Declaração da memória de instruções (256 posições de 8 bits)
reg [7:0] mem [0:255];

initial begin
    for(integer i = 0; i < 256; i++) begin
        mem[i] = 8'b11100000;
    end

    // ================================================================
    // Programa: Bubble Sort (ordem crescente) para mem[0..3]
    // Dados iniciais em memDados.v: [3, 1, 4, 2]
    // Sequencia de comparacoes (bubble sort):
    //   pass 1: (0,1), (1,2), (2,3)
    //   pass 2: (0,1), (1,2)
    //   pass 3: (0,1)
    // ================================================================

    // Inicializa r1 com o endereco de "skip" do bloco 1 (27)
    mem[8]   = 8'b01001111; // LOADI r1, 7
    mem[9]   = 8'b10001111; // INC   r1, 3
    mem[10]  = 8'b10001111; // INC   r1, 3
    mem[11]  = 8'b10001111; // INC   r1, 3
    mem[12]  = 8'b10001111; // INC   r1, 3
    mem[13]  = 8'b10001111; // INC   r1, 3
    mem[14]  = 8'b10001111; // INC   r1, 3
    mem[15]  = 8'b10001101; // INC   r1, 2   -> r1 = 27

    // Bloco 1: compara (0,1)
    mem[16]  = 8'b01000000; // LOADI r0, 0
    mem[17]  = 8'b00100100; // LOAD  [r0] -> r2
    mem[18]  = 8'b01000001; // LOADI r0, 1
    mem[19]  = 8'b00100110; // LOAD  [r0] -> r3
    mem[20]  = 8'b10110110; // CMP   r2, r3
    mem[21]  = 8'b01100001; // JUMP cond=0, r1
    mem[22]  = 8'b11010110; // SWAP  r2, r3
    mem[23]  = 8'b01000000; // LOADI r0, 0
    mem[24]  = 8'b00000100; // STORE [r0] <- r2
    mem[25]  = 8'b01000001; // LOADI r0, 1
    mem[26]  = 8'b00000110; // STORE [r0] <- r3

    // Atualiza r1 para skip do bloco 2 (44)
    mem[27]  = 8'b10001111; // INC   r1, 3
    mem[28]  = 8'b10001111; // INC   r1, 3
    mem[29]  = 8'b10001111; // INC   r1, 3
    mem[30]  = 8'b10001111; // INC   r1, 3
    mem[31]  = 8'b10001111; // INC   r1, 3
    mem[32]  = 8'b10001101; // INC   r1, 2   -> r1 = 44

    // Bloco 2: compara (1,2)
    mem[33]  = 8'b01000001; // LOADI r0, 1
    mem[34]  = 8'b00100100; // LOAD  [r0] -> r2
    mem[35]  = 8'b01000010; // LOADI r0, 2
    mem[36]  = 8'b00100110; // LOAD  [r0] -> r3
    mem[37]  = 8'b10110110; // CMP   r2, r3
    mem[38]  = 8'b01100001; // JUMP cond=0, r1
    mem[39]  = 8'b11010110; // SWAP  r2, r3
    mem[40]  = 8'b01000001; // LOADI r0, 1
    mem[41]  = 8'b00000100; // STORE [r0] <- r2
    mem[42]  = 8'b01000010; // LOADI r0, 2
    mem[43]  = 8'b00000110; // STORE [r0] <- r3

    // Atualiza r1 para skip do bloco 3 (61)
    mem[44]  = 8'b10001111; // INC   r1, 3
    mem[45]  = 8'b10001111; // INC   r1, 3
    mem[46]  = 8'b10001111; // INC   r1, 3
    mem[47]  = 8'b10001111; // INC   r1, 3
    mem[48]  = 8'b10001111; // INC   r1, 3
    mem[49]  = 8'b10001101; // INC   r1, 2   -> r1 = 61

    // Bloco 3: compara (2,3)
    mem[50]  = 8'b01000010; // LOADI r0, 2
    mem[51]  = 8'b00100100; // LOAD  [r0] -> r2
    mem[52]  = 8'b01000011; // LOADI r0, 3
    mem[53]  = 8'b00100110; // LOAD  [r0] -> r3
    mem[54]  = 8'b10110110; // CMP   r2, r3
    mem[55]  = 8'b01100001; // JUMP cond=0, r1
    mem[56]  = 8'b11010110; // SWAP  r2, r3
    mem[57]  = 8'b01000010; // LOADI r0, 2
    mem[58]  = 8'b00000100; // STORE [r0] <- r2
    mem[59]  = 8'b01000011; // LOADI r0, 3
    mem[60]  = 8'b00000110; // STORE [r0] <- r3

    // Atualiza r1 para skip do bloco 4 (78)
    mem[61]  = 8'b10001111; // INC   r1, 3
    mem[62]  = 8'b10001111; // INC   r1, 3
    mem[63]  = 8'b10001111; // INC   r1, 3
    mem[64]  = 8'b10001111; // INC   r1, 3
    mem[65]  = 8'b10001111; // INC   r1, 3
    mem[66]  = 8'b10001101; // INC   r1, 2   -> r1 = 78

    // Bloco 4: compara (0,1)
    mem[67]  = 8'b01000000; // LOADI r0, 0
    mem[68]  = 8'b00100100; // LOAD  [r0] -> r2
    mem[69]  = 8'b01000001; // LOADI r0, 1
    mem[70]  = 8'b00100110; // LOAD  [r0] -> r3
    mem[71]  = 8'b10110110; // CMP   r2, r3
    mem[72]  = 8'b01100001; // JUMP cond=0, r1
    mem[73]  = 8'b11010110; // SWAP  r2, r3
    mem[74]  = 8'b01000000; // LOADI r0, 0
    mem[75]  = 8'b00000100; // STORE [r0] <- r2
    mem[76]  = 8'b01000001; // LOADI r0, 1
    mem[77]  = 8'b00000110; // STORE [r0] <- r3

    // Atualiza r1 para skip do bloco 5 (95)
    mem[78]  = 8'b10001111; // INC   r1, 3
    mem[79]  = 8'b10001111; // INC   r1, 3
    mem[80]  = 8'b10001111; // INC   r1, 3
    mem[81]  = 8'b10001111; // INC   r1, 3
    mem[82]  = 8'b10001111; // INC   r1, 3
    mem[83]  = 8'b10001101; // INC   r1, 2   -> r1 = 95

    // Bloco 5: compara (1,2)
    mem[84]  = 8'b01000001; // LOADI r0, 1
    mem[85]  = 8'b00100100; // LOAD  [r0] -> r2
    mem[86]  = 8'b01000010; // LOADI r0, 2
    mem[87]  = 8'b00100110; // LOAD  [r0] -> r3
    mem[88]  = 8'b10110110; // CMP   r2, r3
    mem[89]  = 8'b01100001; // JUMP cond=0, r1
    mem[90]  = 8'b11010110; // SWAP  r2, r3
    mem[91]  = 8'b01000001; // LOADI r0, 1
    mem[92]  = 8'b00000100; // STORE [r0] <- r2
    mem[93]  = 8'b01000010; // LOADI r0, 2
    mem[94]  = 8'b00000110; // STORE [r0] <- r3

    // Atualiza r1 para skip do bloco 6/fim (112)
    mem[95]  = 8'b10001111; // INC   r1, 3
    mem[96]  = 8'b10001111; // INC   r1, 3
    mem[97]  = 8'b10001111; // INC   r1, 3
    mem[98]  = 8'b10001111; // INC   r1, 3
    mem[99]  = 8'b10001111; // INC   r1, 3
    mem[100] = 8'b10001101; // INC   r1, 2   -> r1 = 112

    // Bloco 6: compara (0,1)
    mem[101] = 8'b01000000; // LOADI r0, 0
    mem[102] = 8'b00100100; // LOAD  [r0] -> r2
    mem[103] = 8'b01000001; // LOADI r0, 1
    mem[104] = 8'b00100110; // LOAD  [r0] -> r3
    mem[105] = 8'b10110110; // CMP   r2, r3
    mem[106] = 8'b01100001; // JUMP cond=0, r1
    mem[107] = 8'b11010110; // SWAP  r2, r3
    mem[108] = 8'b01000000; // LOADI r0, 0
    mem[109] = 8'b00000100; // STORE [r0] <- r2
    mem[110] = 8'b01000001; // LOADI r0, 1
    mem[111] = 8'b00000110; // STORE [r0] <- r3

    // Fim
    mem[112] = 8'b11100000; // HALT
end

// Leitura combinacional (a instrução tem que estar pronta no mesmo ciclo do PC atual)
assign inst = mem[endereco];

endmodule