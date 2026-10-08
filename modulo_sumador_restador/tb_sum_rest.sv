`timescale 1ns/1ps

module tb_sum_rest;

    // Configuración de parámetros para la prueba
    localparam BITS = 4; // Puedes cambiarlo a 8, 16, etc.

    // Señales de prueba (Estímulos)
    logic [BITS-1:0] aa, bb;
    logic            cin, x;

    // Salidas del DUT (Device Under Test)
    logic [BITS-1:0] ss;
    logic            cout, vout;

    // Instanciación del módulo sum_rest
    sum_rest #(.N(BITS)) dut (
        .aa  (aa),
        .bb  (bb),
        .cin (cin),
        .x   (x),
        .ss  (ss),
        .cout(cout),
        .vout(vout)
    );

    // Bloque principal de estímulos
    initial begin
        // Configuración para guardar ondas en GTKWave / VS Code
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_sum_rest);

        $display("--------------------------------------------------");
        $display("  INICIANDO SIMULACION DEL SUMADOR/RESTADOR (%0d BITS)", BITS);
        $display("--------------------------------------------------");

        // =========================================================
        // 1. PRUEBAS DE SUMA (x = 0)
        // =========================================================
        x = 0; cin = 0;

        // Caso 1.1: Suma positiva simple: (+5) + (+2) = +7 (0101 + 0010 = 0111)
        aa = 4'd5; bb = 4'd2; #10;
        $display("SUMA:  %d + %d = %d | vout=%b | cout=%b", $signed(aa), $signed(bb), $signed(ss), vout, cout);

        // Caso 1.2: Suma con Carry Out: (+7) + (+1) = +8 -> Overflow en 4 bits
        // En 4 bits con signo, +8 no cabe (rango -8 a +7), activa vout=1
        aa = 4'd7; bb = 4'd1; #10;
        $display("SUMA:  %d + %d = %d | vout=%b | cout=%b (Overflow)", $signed(aa), $signed(bb), $signed(ss), vout, cout);

        // Caso 1.3: Suma de negativos con Overflow: (-7) + (-8) = -15 (Fuera de rango)
        aa = -4'd7; bb = -4'd8; #10;
        $display("SUMA: %d + %d = %d | vout=%b | cout=%b (Overflow)", $signed(aa), $signed(bb), $signed(ss), vout, cout);

        // =========================================================
        // 2. PRUEBAS DE RESTA (x = 1)
        // =========================================================
        x = 1; cin = 0; // x=1 fuerza el +1 en complemento a 2

        // Caso 2.1: Resta simple: (+7) - (+2) = +5 (0111 - 0010 = 0101)
        aa = 4'd7; bb = 4'd2; #10;
        $display("RESTA: %d - %d = %d | vout=%b | cout=%b", $signed(aa), $signed(bb), $signed(ss), vout, cout);

        // Caso 2.2: Resta con resultado negativo: (+5) - (+7) = -2
        aa = 4'd5; bb = 4'd7; #10;
        $display("RESTA: %d - %d = %d | vout=%b | cout=%b", $signed(aa), $signed(bb), $signed(ss), vout, cout);

        // Caso 2.3: Resta con Overflow: (+7) - (-2) = +9 (Fuera de rango en 4 bits)
        aa = 4'd7; bb = -4'd2; #10;
        $display("RESTA: %d - %d = %d | vout=%b | cout=%b (Overflow)", $signed(aa), $signed(bb), $signed(ss), vout, cout);

        $display("--------------------------------------------------");
        $display("  SIMULACION FINALIZADA CON EXITO");
        $display("--------------------------------------------------");
        $finish;
    end

endmodule