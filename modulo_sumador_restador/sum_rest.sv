module sum_rest #(parameter N = 4) (
    input logic [N-1:0] aa, bb, 
    input logic cin, x,
    output logic [N-1:0] ss, 
    output logic cout, vout
);

    //seleccionador de opracion
    logic [N-1:0] oper;
    //creo el vector de acarreo de N+1 bits 
    logic [N:0] cc;
    // cc[0] es el carry de entrada, que es cin
    // cc[N] es el carry de salida, que es cout
    //cc[N-1] es el carry qu entra al bit MSB, osea el de signo

    assign oper = x ? ~bb : bb; // si x==1 etonces resta, si x==0 hace suma
    //asignación del carry de entrada, 1 si es resta, 0 si es suma (para el +1 del complemento a 2)
   
    assign cc[0] = x ? 1'b1 : cin; // si es resta, el carry de entrada es 1, si es suma, es cin
    //creamos el bucle para N sumadores 
    genvar i;
    generate
        for (i=0; i<N; i= i+1) begin : gen_adder 
          fa fa_inst (.a(aa[i]),
           .b(oper[i]), 
           .cin(cc[i]),
            .s(ss[i]), 
            .cout(cc[i+1])
            );
        end
    endgenerate

    assign cout = cc[N];
    assign vout = cc[N] ^ cc[N-1]; 
endmodule 