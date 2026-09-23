`timescale 1ns/1ps

module tb_mux;

    // Parámetros y señales
    localparam WIDTH = 4;
    
    logic [WIDTH-1:0] in0, in1, in2, in3;
    logic [1:0]       sel;
    logic [WIDTH-1:0] out;

    // Instancia del módulo a probar (UUT)
    mux #(
        .WIDTH(WIDTH)
    ) uut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(sel),
        .out(out)
    );

    // Generación de archivo VCD para el visor de ondas
    initial begin
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_mux);
    end

    // Estímulos
    initial begin
        // Asignar valores fijos a las entradas de prueba
        in0 = 4'b0001; // 1
        in1 = 4'b0010; // 2
        in2 = 4'b0100; // 4
        in3 = 4'b1000; // 8
        sel = 2'b00;

        #10 sel = 2'b00; // Salida: in0 (1)
        #10 sel = 2'b01; // Salida: in1 (2)
        #10 sel = 2'b10; // Salida: in2 (4)
        #10 sel = 2'b11; // Salida: in3 (8)
        #10;

        $finish;
    end

endmodule