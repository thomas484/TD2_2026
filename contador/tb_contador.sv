`timescale 1ns/1ps

module tb_contador;
    logic       clk;
    logic       rst;
    logic [3:0] cuenta;

    // Instancia del contador
    contador uut (
        .clk(clk),
        .rst(rst),
        .cuenta(cuenta)
    );

    // Generador de Reloj: Cambia de estado cada 5ns (Periodo total = 10ns)
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    initial begin
        // Configuración para el archivo de ondas
        $dumpfile("simulacion.vcd");
        $dumpvars(0, tb_contador);

        // Estímulos iniciales
        rst = 1; #15;      // Activa el reset por 15ns para limpiar el circuito
        rst = 0; #150;     // Desactiva el reset para dejarlo contar un buen tiempo
        
        rst = 1; #10;      // Vuelve a activar el reset un instante para probarlo
        rst = 0; #40;      // Deja contar un poco más

        $finish;           // Termina la simulación
    end
endmodule
