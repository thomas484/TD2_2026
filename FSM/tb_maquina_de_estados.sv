`timescale 1ns/1ps

module tb_maquina_de_estados;
    logic clk;
    logic reset;
    logic a;
    logic y;

    // Instanciación del Módulo Bajo Prueba (DUT)
    maquina_de_estados dut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .y(y)
    );

    // Generador de Reloj: Periodo de 10ns (5ns en alto, 5ns en bajo)
    always #5 clk = ~clk;

    initial begin
        // --- CONFIGURACIÓN PARA GENERAR ONDAS VCD ---
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_maquina_de_estados);
        // ---------------------------------------------

        // Inicialización de señales
        clk = 0;
        reset = 1;
        a = 0;

        // Liberar el Reset tras 12ns
        #12 reset = 0;

        // --- SECUENCIA DE PRUEBA '1101' ---
        #10 a = 1; // Recibe '1' -> Pasa a S1
        #10 a = 1; // Recibe '1' -> Pasa a S2
        #10 a = 0; // Recibe '0' -> Pasa a S3
        #10 a = 1; // Recibe '1' -> Pasa a S4 (y debe activarse la salida y = 1)

        // Continuación para evaluar transiciones desde S4
        #10 a = 0; // Transición posterior
        #20;

        $display("Simulación finalizada con éxito.");
        $finish; // Cierra y escribe el archivo .vcd en disco
    end
endmodule