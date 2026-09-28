module maquina_de_estados (
    input  logic clk,
    input  logic reset,
    input  logic a,     // Entrada serial de 1 bit
    output logic y      // Salida de 1 bit
);

    // Definición de estados compatible con Icarus Verilog
    localparam S0 = 3'b000; // Estado inicial
    localparam S1 = 3'b001; // Detectado '1'
    localparam S2 = 3'b010; // Detectado '11'
    localparam S3 = 3'b011; // Detectado '110'
    localparam S4 = 3'b100; // Detectado '1101' (Salida = 1)

    logic [2:0] state, nextstate;

    // 1. Registro de Estado (Lógica Secuencial)
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= nextstate;
    end

    // 2. Lógica de Estado Siguiente (Lógica Combinacional)
    always_comb begin
        case (state)
            S0: nextstate = a ? S1 : S0;
            S1: nextstate = a ? S2 : S0;
            S2: nextstate = a ? S2 : S3;
            S3: nextstate = a ? S4 : S0;
            S4: nextstate = a ? S2 : S0; // Manejo de solapamiento
            default: nextstate = S0;
        endcase
    end

    // 3. Lógica de Salida (Moore: depende sólo del estado actual)
    assign y = (state == S4);

endmodule