`timescale 1ns/1ps

module tb_memoryRamUni;

    // Parámetros reducidos para la prueba rápida
    localparam N = 4; // 16 posiciones (0 a 15)
    localparam M = 8; // Palabras de 8 bits

    // Señales de prueba
    logic         clk;
    logic         we;
    logic [M-1:0] data_in;
    logic [N-1:0] address;
    logic [M-1:0] data_out;

    // Instancia de la memoria a probar (UUT)
    memoryRamUni #(
        .N(N),
        .M(M)
    ) uut (
        .clk(clk),
        .we(we),
        .data_in(data_in),
        .address(address),
        .data_out(data_out)
    );

    // Generación de reloj de 10ns de período (50 MHz)
    always #5 clk = ~clk;

    // Archivo VCD para el visor de ondas
    initial begin
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_memoryRamUni);
    end

    // Proceso de estímulos
    initial begin
        // Estado inicial
        clk      = 0;
        we       = 0;
        address  = 0;
        data_in  = 0;

        #10;

        // 1. Escribir valor 8'hAA (170) en la dirección 4'h2
        we      = 1;
        address = 4'h2;
        data_in = 8'hAA;
        #10; // Espera al flanco ascendente de reloj

        // 2. Escribir valor 8'h55 (85) en la dirección 4'h5
        address = 4'h5;
        data_in = 8'h55;
        #10;

        // 3. Deshabilitar escritura y leer las posiciones guardadas
        we = 0;

        // Leer dirección 4'h2 (Debe salir 8'hAA)
        address = 4'h2;
        #10;

        // Leer dirección 4'h5 (Debe salir 8'h55)
        address = 4'h5;
        #10;

        // Leer dirección no escrita 4'h0 (Debe salir x o 0 según inicialización)
        address = 4'h0;
        #10;

        $finish;
    end

endmodule