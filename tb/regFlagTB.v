module regFlagTB;

reg CLOCK;
reg escFlag;
reg flag;
wire saiFlag;

// Instanciação do modulo
regFlag regFlag_inst(CLOCK, escFlag, flag, saiFlag);

// Geração do clock
initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

initial begin
    // Inicialização
    escFlag = 0;
    flag = 0;
    #10;
    $display("saiFlag inicial: %b", saiFlag);

    // sem escFlag, nao atualiza
    flag = 1;
    #10;
    $display("saiFlag com escFlag=0 e flag=1: %b", saiFlag);

    // Seta flag para 1 e espera borda de subida
    escFlag = 1;
    flag = 1;
    #10;
    $display("saiFlag apos flag=1: %b", saiFlag);

    // Seta flag para 0 e espera borda de subida
    flag = 0;
    #10;
    $display("saiFlag apos flag=0: %b", saiFlag);

    $finish;
end

endmodule
