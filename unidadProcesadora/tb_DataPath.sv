`timescale 1ns/1ps

module tb_DataPath;

    // Declaración de entradas para el DataPath
    logic        clk;
    logic [15:0] ctrl_word;
    logic [3:0]  data_in;

    // Declaración de salidas del DataPath
    logic [3:0]  data_out;
    logic [3:0]  state_bits;

    // Instanciación del módulo DataPath respetando exactamente tus puertos
    DataPath uut (
        .clk(clk),
        .ctrl_word(ctrl_word),
        .data_in(data_in),
        .data_out(data_out),
        .state_bits(state_bits)
    );

    // Generación del reloj (período de 10ns)
    always #5 clk = ~clk;

    // Generación del archivo VCD para WaveTrace
    initial begin
        $dumpfile("simulacion_datapath.vcd");
        $dumpvars(0, tb_DataPath);
    end

    // Proceso de estímulos respetando el formato HHH-FFFF-DDD-BBB-AAA
    initial begin
        // Inicialización de señales
        clk       = 0;
        ctrl_word = 16'h0000;
        data_in   = 4'b0000;

        #10;

        // ---------------------------------------------------------------------
        // CASO 1: Cargar valor 4'b0101 (5) desde data_in hacia Registro 1 (R1)
        // a=000 (toma data_in), b=000, d=001 (escribe en R1), f=0000 (Pass A), h=000 (No shift)
        // ctrl_word = {3'b000, 4'b0000, 3'b001, 3'b000, 3'b000}
        // ---------------------------------------------------------------------
        $display("--- CASO 1: Cargar 5 en R1 ---");
        data_in   = 4'b0101;
        ctrl_word = 16'b000_0000_001_000_000;
        #10; // Flanco ascendente escribe data_out (5) en R1

        // ---------------------------------------------------------------------
        // CASO 2: Cargar valor 4'b0011 (3) desde data_in hacia Registro 2 (R2)
        // a=000, b=000, d=010 (escribe en R2), f=0000, h=000
        // ctrl_word = {3'b000, 4'b0000, 3'b010, 3'b000, 3'b000}
        // ---------------------------------------------------------------------
        $display("--- CASO 2: Cargar 3 en R2 ---");
        data_in   = 4'b0011;
        ctrl_word = 16'b000_0000_010_000_000;
        #10; // Flanco ascendente escribe 3 en R2

        // ---------------------------------------------------------------------
        // CASO 3: Sumar R1 + R2 y escribir el resultado (8) en Registro 3 (R3)
        // a=001 (R1=5), b=010 (R2=3), d=011 (R3), f=0001 (Suma A+B), h=000 (No shift)
        // ctrl_word = {3'b000, 4'b0001, 3'b011, 3'b010, 3'b001}
        // ---------------------------------------------------------------------
        $display("--- CASO 3: R3 = R1 + R2 (5 + 3 = 8) ---");
        ctrl_word = 16'b000_0001_011_010_001;
        #10; // En posedge clk se actualiza R3 con 8 y se cargan las flags en state_bits

        // ---------------------------------------------------------------------
        // CASO 4: Leer R3 (8), aplicar Shift Left (h=001) y guardar en Registro 4 (R4)
        // a=011 (R3), b=000, d=100 (R4), f=0000 (Pass A), h=001 (Shift Left)
        // ctrl_word = {3'b001, 4'b0000, 3'b100, 3'b000, 3'b011}
        // ---------------------------------------------------------------------
        $display("--- CASO 4: Desplazamiento a la izquierda de R3 hacia R4 ---");
        ctrl_word = 16'b001_0000_100_000_011;
        #10;

        // ---------------------------------------------------------------------
        // CASO 5: Lectura pasante de R4 (d=000 deshabilita la escritura d!=0)
        // a=100 (R4), b=000, d=000 (sin escritura), f=0000, h=000
        // ctrl_word = {3'b000, 4'b0000, 3'b000, 3'b000, 3'b100}
        // ---------------------------------------------------------------------
        $display("--- CASO 5: Lectura directa de R4 ---");
        ctrl_word = 16'b000_0000_000_000_100;
        #10;

        $display("Simulacion del DataPath finalizada con exito.");
        $finish;
    end

endmodule