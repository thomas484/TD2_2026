module unidad_de_corrimiento_4_bits(
    input logic [3:0] data_in, 
    input logic [1:0] select,
    input logic input_left, input_right, 
    output logic [3:0] data_out
);

always_comb begin
    case(select)

    0: data_out = data_in; //directo 
    1: data_out = {data_in[2:0], input_left}; // desplazamiento a la izquierda (le saca el bit MSB a data_in y completa con la entrada input_left)
    2: data_out = {input_right, data_in[3:1]}; // desplazamiento a la derecha (le saca el bit LSB a data_in y completa con la entrada input_right)
    3: data_out = 4'b0000; //reset pone a cero la salida
       endcase

end


endmodule