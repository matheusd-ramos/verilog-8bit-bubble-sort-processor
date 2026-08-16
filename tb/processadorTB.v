module processadorTB;

reg CLOCK;
integer ciclo;
reg [7:0] last_r0, last_r1, last_r2, last_r3;

// Instanciação do processador
processador proc(.CLOCK(CLOCK));

// Geração do clock
initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

// Controle de ciclos e exibição
initial begin
    ciclo = 1;
    last_r0 = 0; last_r1 = 0; last_r2 = 0; last_r3 = 0;
    $display("Iniciando simulacao do processador...");
    $display("PC | Instrucao | r0 | r1 | r2 | r3");

    repeat (100) begin
        @(negedge CLOCK);
        // Mostra PC e instrução a cada ciclo
        $display("%2d | %b | %2d | %2d | %2d | %2d", 
            proc.pc_modulo.pc, proc.memInst_modulo.mem[proc.pc_modulo.pc], 
            proc.bancoRegs_modulo.r0, proc.bancoRegs_modulo.r1, 
            proc.bancoRegs_modulo.r2, proc.bancoRegs_modulo.r3);

        // Mostra registradores só se mudarem
        if (proc.bancoRegs_modulo.r0 !== last_r0 ||
            proc.bancoRegs_modulo.r1 !== last_r1 ||
            proc.bancoRegs_modulo.r2 !== last_r2 ||
            proc.bancoRegs_modulo.r3 !== last_r3) begin
            $display("Reg: r0=%0d r1=%0d r2=%0d r3=%0d", 
                proc.bancoRegs_modulo.r0, proc.bancoRegs_modulo.r1, 
                proc.bancoRegs_modulo.r2, proc.bancoRegs_modulo.r3);
            last_r0 = proc.bancoRegs_modulo.r0;
            last_r1 = proc.bancoRegs_modulo.r1;
            last_r2 = proc.bancoRegs_modulo.r2;
            last_r3 = proc.bancoRegs_modulo.r3;
        end

        if (proc.Halt) begin
            $display("HALT encontrado no PC=%d", proc.pc_modulo.pc);
            $display("Memoria final: mem[0]=%0d mem[1]=%0d mem[2]=%0d mem[3]=%0d", 
                proc.memDados_modulo.mem[0], proc.memDados_modulo.mem[1], 
                proc.memDados_modulo.mem[2], proc.memDados_modulo.mem[3]);
            $finish;
        end
    end
    $display("Fim da simulação (limite de ciclos atingido).");
    $display("Memória final: mem[0]=%0d mem[1]=%0d mem[2]=%0d mem[3]=%0d", 
        proc.memDados_modulo.mem[0], proc.memDados_modulo.mem[1], 
        proc.memDados_modulo.mem[2], proc.memDados_modulo.mem[3]);
    $finish;
end

endmodule