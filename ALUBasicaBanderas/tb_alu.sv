`timescale 1ns/1ps

module tb_alu;

    // Entradas
    logic [31:0] a, b;
    logic [1:0]  ALUControl;

    // Salidas del DUT
    logic [31:0] Result;
    logic [3:0]  AluFlags; // Vector {neg, zero, carry, overflow}

    // Instanciación de la ALU
    alu dut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .Result(Result),
        .AluFlags(AluFlags)
    );

    initial begin
        // Configuración para guardar ondas .vcd
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_alu);

        $display("------------------------------------------------------------------");
        $display("                  SIMULACIÓN ALU CON VECTOR DE FLAGS              ");
        $display("------------------------------------------------------------------");

        // 1. SUMA SIMPLE
        ALUControl = 2'b00; a = 32'd15; b = 32'd10; #10;
        $display("[SUMA]  %d + %d = %d | AluFlags {N,Z,C,V} = %b", $signed(a), $signed(b), $signed(Result), AluFlags);

        // 2. SUMA CON OVERFLOW (0x7FFFFFFF + 1)
        ALUControl = 2'b00; a = 32'h7FFFFFFF; b = 32'd1; #10;
        $display("[SUMA - OVERFLOW] 0x%h + %d = 0x%h | AluFlags {N,Z,C,V} = %b", a, b, Result, AluFlags);

        // 3. RESTA CON RESULTADO ZERO
        ALUControl = 2'b01; a = 32'd25; b = 32'd25; #10;
        $display("[RESTA - ZERO]    %d - %d = %d | AluFlags {N,Z,C,V} = %b", $signed(a), $signed(b), $signed(Result), AluFlags);

        // 4. RESTA CON RESULTADO NEGATIVO
        ALUControl = 2'b01; a = 32'd10; b = 32'd20; #10;
        $display("[RESTA - NEG]     %d - %d = %d | AluFlags {N,Z,C,V} = %b", $signed(a), $signed(b), $signed(Result), AluFlags);

        // 5. OPERACION LOGICA AND
        ALUControl = 2'b10; a = 32'hF0F0_FFFF; b = 32'hFFFF_0000; #10;
        $display("[AND]   0x%h & 0x%h = 0x%h | AluFlags {N,Z,C,V} = %b", a, b, Result, AluFlags);

        // 6. OPERACION LOGICA OR
        ALUControl = 2'b11; a = 32'hF0F0_0000; b = 32'h0000_FFFF; #10;
        $display("[OR]    0x%h | 0x%h = 0x%h | AluFlags {N,Z,C,V} = %b", a, b, Result, AluFlags);

        $display("------------------------------------------------------------------");
        $display("                     SIMULACIÓN FINALIZADA                        ");
        $display("------------------------------------------------------------------");
        $finish;
    end

endmodule