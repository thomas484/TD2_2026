`timescale 1ns/1ps

module tb_unidad_de_corrimiento_4_bits;

    // Declaración de señales de prueba
    logic [3:0] data_in;
    logic [1:0] select;
    logic       input_left;
    logic       input_right;
    logic [3:0] data_out;

    // Instancia del Módulo a Probar (UUT)
    unidad_de_corrimiento_4_bits uut (
        .data_in(data_in),
        .select(select),
        .input_left(input_left),
        .input_right(input_right),
        .data_out(data_out)
    );

    // Generación del archivo VCD para el visor de ondas
    initial begin
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_unidad_de_corrimiento_4_bits);
    end

    // Proceso de estímulos
    initial begin
        // Valores iniciales
        data_in     = 4'b1011; // Dato de prueba: 1011 (11 decimal)
        input_left  = 1'b0;
        input_right = 1'b0;
        select      = 2'b00;

        #10;
        // Caso 0: Transferencia Directa (data_out = 1011)
        select = 2'b00;
        #10;

        // Caso 1: Shift Left rellenando con 0 (data_out = 0110)
        select     = 2'b01;
        input_left = 1'b0;
        #10;

        // Caso 1: Shift Left rellenando con 1 (data_out = 0111)
        select     = 2'b01;
        input_left = 1'b1;
        #10;

        // Caso 2: Shift Right rellenando con 0 (data_out = 0101)
        select      = 2'b10;
        input_right = 1'b0;
        #10;

        // Caso 2: Shift Right rellenando con 1 (data_out = 1101)
        select      = 2'b10;
        input_right = 1'b1;
        #10;

        // Caso 2: Rotador a la derecha (conectando el bit LSB de data_in a input_right)
        select      = 2'b10;
        input_right = data_in[0]; // data_in[0] = 1 -> data_out = 1101
        #10;

        // Caso 3: Salida a cero (data_out = 0000)
        select = 2'b11;
        #10;

        $finish;
    end

endmodule