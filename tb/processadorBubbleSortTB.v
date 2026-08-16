module processadorBubbleSortTB;

    reg CLOCK;
    integer ciclo;

    // Instancia o processador completo
    processador dut(.CLOCK(CLOCK));

    // Clock de 10 unidades de tempo (100 MHz equivalente em escala arbitraria)
    initial begin
        CLOCK = 1'b0;
        forever #5 CLOCK = ~CLOCK;
    end

    task print_header;
    begin
        $display("==============================================================");
        $display("                PROCESSADOR 8 BITS - BUBBLE SORT             ");
        $display("==============================================================");
        $display("Ciclo | PC  | Instrucao | r0  r1  r2  r3 | mem0 mem1 mem2 mem3");
        $display("--------------------------------------------------------------");
    end
    endtask

    task print_state;
    begin
        $display("%5d | %3d | %08b | %2d  %2d  %2d  %2d | %4d %4d %4d %4d",
                 ciclo,
                 dut.pc_modulo.pc,
                 dut.memInst_modulo.mem[dut.pc_modulo.pc],
                 dut.bancoRegs_modulo.r0,
                 dut.bancoRegs_modulo.r1,
                 dut.bancoRegs_modulo.r2,
                 dut.bancoRegs_modulo.r3,
                 dut.memDados_modulo.mem[0],
                 dut.memDados_modulo.mem[1],
                 dut.memDados_modulo.mem[2],
                 dut.memDados_modulo.mem[3]);
    end
    endtask

    task check_result;
    begin
        $display("--------------------------------------------------------------");
        $display("Memoria final: [%0d, %0d, %0d, %0d]",
                 dut.memDados_modulo.mem[0],
                 dut.memDados_modulo.mem[1],
                 dut.memDados_modulo.mem[2],
                 dut.memDados_modulo.mem[3]);

        if (dut.memDados_modulo.mem[0] == 8'd1 &&
            dut.memDados_modulo.mem[1] == 8'd2 &&
            dut.memDados_modulo.mem[2] == 8'd3 &&
            dut.memDados_modulo.mem[3] == 8'd4) begin
            $display("STATUS: PASS - Bubble Sort executado com sucesso.");
        end else begin
            $display("STATUS: FAIL - Vetor nao foi ordenado corretamente.");
        end
        $display("==============================================================");
    end
    endtask

    initial begin
        $dumpfile("build/vcd/processadorBubbleSortTB.vcd");
        $dumpvars(0, processadorBubbleSortTB);

        ciclo = 0;

        print_header();
        print_state();

        // Limite de ciclos para evitar simulacao infinita em caso de erro
        begin : run_loop
            repeat (250) begin
                @(negedge CLOCK);
                ciclo = ciclo + 1;
                print_state();

                if (dut.Halt) begin
                    disable run_loop;
                end
            end
        end

        if (dut.Halt) begin
            $display("HALT detectado no ciclo %0d (PC=%0d).", ciclo, dut.pc_modulo.pc);
        end else begin
            $display("HALT NAO detectado dentro do limite de ciclos.");
        end

        check_result();
        $finish;
    end

endmodule
