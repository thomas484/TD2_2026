module alu(
    input logic [31:0] a, b, 
    input logic [1:0] ALUControl, 
    output logic [31:0] Result, 
    output logic [3:0] AluFlags
);

//creo las salidas internas 
logic [32:0] sum; //tiene un bit mas para el carry de salida
logic [31:0] condinvb; //invertir b si es resta
logic neg, zero, carry, overflow; //flags de salida

//seleccion de operación
assign condinvb = ALUControl[0] ? ~b : b; // si ALUControl[0] es 1, resta e invierto b, sino suma  y asigno b
//realizo la suma o resta 
assign sum = a + condinvb + ALUControl[0]; // si es resta, sumo 1 al carry de entrada que vale 1 y me completa el complemento a 2
//selecciono la salida de la ALU según la palabra de control ALUControl[1:0]
always_comb 
    casex (ALUControl[1:0])
       2'b0?: Result = sum; //suma o resta
       2'b10: Result = a & b; //AND
       2'b11: Result = a | b; //OR
        default: Result = 32'b0; //default pone la salida en 0
    endcase
    //asigno las banderas de salida para luego armar el vecto de flags
    assign neg = Result[31]; //negativo si el bit de signo es 1
    assign zero = Result == 32'b0; //zero si la salida es 0
    assign carry = (ALUControl[1]==1'b0) & sum[32]; // carry solo para suma o resta aritmetica, si es AND o OR no hay carry
    assign overflow = (ALUControl[1] == 1'b0) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);
    assign AluFlags = {neg, zero, carry, overflow}; //armo el vector de flags de salida
endmodule