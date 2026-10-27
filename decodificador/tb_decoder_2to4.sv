`timescale 1ns/1ps

module tb_decoder_2to4;

    // Declaración de señales
    logic [1:0] sel;
    logic       enable;
    logic [3:0] out;

    // Instancia del módulo a probar (UUT)
    decoder_2to4 uut (
        .sel(sel),
        .enable(enable),
        .out(out)
    );

    // Generación del archivo VCD para el visor de ondas
    initial begin
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_decoder_2to4);
    end

    // Proceso de estímulos
    initial begin
        // Estado inicial
        sel    = 2'b00;
        enable = 1'b0;

        // 1. Probar estado deshabilitado (enable = 0)
        #10;
        sel = 2'b00; // out debe ser 0000
        #10;
        sel = 2'b11; // out debe ser 0000 aunque cambie sel

        // 2. Habilitar decodificador (enable = 1)
        #10;
        enable = 1'b1;

        // Probar selección 00 -> out = 0001
        sel = 2'b00;
        #10;

        // Probar selección 01 -> out = 0010
        sel = 2'b01;
        #10;

        // Probar selección 10 -> out = 0100
        sel = 2'b10;
        #10;

        // Probar selección 11 -> out = 1000
        sel = 2'b11;
        #10;

        // 3. Deshabilitar en medio de la operación
        enable = 1'b0;
        #10;

        $finish;
    end

endmodule