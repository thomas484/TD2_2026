`timescale 1ns/1ps

module tb_sumador;
    logic [3:0] a;
    logic [3:0] b;
    logic [4:0] suma;

    sumador uut (
        .a(a),
        .b(b),
        .suma(suma)
    );

    initial begin
        // Esto le indica a Verilator que cree el archivo de ondas
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_sumador);

        // Casos de prueba
        a = 4'd5;  b = 4'd3;  #10;
        a = 4'd10; b = 4'd7;  #10;
        a = 4'd15; b = 4'd1;  #10;

        $finish;
    end
endmodule
