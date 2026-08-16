module controleTB;

// Sinais de teste
reg [7:0] instrucao;
wire [1:0] MemToReg;
wire LeMem, EscMem, ALUOp, Jump, ALUSrc, EscReg1, EscReg2, Halt, DestR2, EscFlag;

// Instância do módulo controle
controle ctrl(instrucao, MemToReg, LeMem, EscMem, ALUOp, Jump, ALUSrc, EscReg1, EscReg2, Halt, DestR2, EscFlag);

task mostra(input [127:0] nome);
begin
    $display("%0s:", nome);
    $display("  MemToReg: %b, LeMem: %b, EscMem: %b, DestR2: %b", MemToReg, LeMem, EscMem, DestR2);
    $display("  ALUOp: %b, Jump: %b, ALUSrc: %b", ALUOp, Jump, ALUSrc);
    $display("  EscReg1: %b, EscReg2: %b, EscFlag: %b, Halt: %b", EscReg1, EscReg2, EscFlag, Halt);
    $display("");
end
endtask

// Geração de formas de onda
initial begin
    $dumpfile("build/vcd/controleTB.vcd");
    $dumpvars(0, controleTB);

    // STORE (000)
    instrucao = 8'b00000000;
    #10; mostra("STORE (000)");

    // LOAD (001)
    instrucao = 8'b00100000;
    #10; mostra("LOAD (001)");

    // LOADI (010)
    instrucao = 8'b01000000;
    #10; mostra("LOADI (010)");

    // JUMP (011)
    instrucao = 8'b01100000;
    #10; mostra("JUMP (011)");

    // DEC (100, funct = 0)
    instrucao = 8'b10000000;
    #10; mostra("DEC (100, funct = 0)");

    // INC (100, funct = 1)
    instrucao = 8'b10000001;
    #10; mostra("INC (100, funct = 1)");

    // CMP (101)
    instrucao = 8'b10100000;
    #10; mostra("CMP (101)");

    // SWAP (110)
    instrucao = 8'b11000000;
    #10; mostra("SWAP (110)");

    // HALT (111)
    instrucao = 8'b11100000;
    #10; mostra("HALT (111)");

    $finish;
end

endmodule