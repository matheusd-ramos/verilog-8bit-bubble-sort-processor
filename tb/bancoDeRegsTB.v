module bancoDeRegsTB;

// Sinais de teste
reg CLOCK;
reg [7:0] dado;
reg escReg1, escReg2;
reg [1:0] R1, R2, RegEscrita;
wire [7:0] S1, S2;

// Instanciação do módulo (nova ordem de portas: R1, R2, RegEscrita, dado, escReg1, escReg2, S1, S2, CLOCK)
bancoDeRegs banco(R1, R2, RegEscrita, dado, escReg1, escReg2, S1, S2, CLOCK);

// Clock simples
initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

// Teste principal
initial begin
    // Inicialização
    dado = 8'b00000000;
    escReg1 = 0;
    escReg2 = 0;
    R1 = 2'b00;
    R2 = 2'b00;
    RegEscrita = 2'b00;

    // Teste 1: Escrever valores nos quatro registradores via RegEscrita
    dado = 8'b00000001; RegEscrita = 2'b00; escReg2 = 1; #10; escReg2 = 0;
    dado = 8'b00000010; RegEscrita = 2'b01; escReg2 = 1; #10; escReg2 = 0;
    dado = 8'b00000011; RegEscrita = 2'b10; escReg2 = 1; #10; escReg2 = 0;
    dado = 8'b00000100; RegEscrita = 2'b11; escReg2 = 1; #10; escReg2 = 0;

    $display("----------------------------------------");
    $display("Lendo registradores...");

    // Teste 2: Ler registradores (esperado: R0=1, R1=2, R2=3, R3=4)
    R1 = 2'b00; R2 = 2'b01; #10;
    $display("R0 =%d, R1 =%d", S1, S2);

    R1 = 2'b10; R2 = 2'b11; #10;
    $display("R2 =%d, R3 =%d", S1, S2);

    $display("----------------------------------------");

    // Teste 3: Tentar escrever com escReg2 desativado (nao deve alterar nada)
    $display("Testando escrita com escReg2 desativado...");
    escReg2 = 0; #5;
    dado = 8'b11111111; RegEscrita = 2'b00; #10;

    R1 = 2'b00; R2 = 2'b01; #10;
    $display("Apos tentativa de escrita - R0=%d, R1=%d (esperado: R0=1, R1=2)", S1, S2);

    $display("----------------------------------------");

    // Teste 4: Tentar troca com apenas escReg1 ativado (nao deve trocar)
    $display("Testando troca com apenas escReg1 ativado...");
    R1 = 2'b00; R2 = 2'b11; escReg1 = 1; escReg2 = 0; #10;
    escReg1 = 0;

    R1 = 2'b00; R2 = 2'b11; #10;
    $display("Apos tentativa de troca (escReg1=1, escReg2=0) - R0=%d, R3=%d (esperado: R0=1, R3=4)", S1, S2);

    $display("----------------------------------------");

    // Teste 5: Tentar troca com apenas escReg2 ativado (deve fazer escrita simples via RegEscrita, nao troca)
    $display("Testando escrita simples com apenas escReg2 ativado...");
    dado = 8'b00110011; RegEscrita = 2'b11; escReg2 = 1; R1 = 2'b00; R2 = 2'b11; escReg1 = 0; #10;
    escReg2 = 0;

    R1 = 2'b00; R2 = 2'b11; #10;
    $display("Apos escrita simples em R3 - R0=%d, R3=%d (esperado: R0=1, R3=51)", S1, S2);

    $display("----------------------------------------");

    // Teste 6: Trocar R0 com R3 (ambos sinais ativados, usa R1 e R2 - RegEscrita nao importa aqui)
    R1 = 2'b00; R2 = 2'b11; escReg1 = 1; escReg2 = 1; #10;
    escReg1 = 0; escReg2 = 0;

    $display("Trocando R0 com R3 (ambos sinais ativados)...");

    R1 = 2'b00; R2 = 2'b11; #10;
    $display("Apos troca - R0=%d, R3=%d (esperado: R0=51, R3=1)", S1, S2);

    $display("----------------------------------------");
    $display("Teste concluido!");

    $finish;
end

endmodule