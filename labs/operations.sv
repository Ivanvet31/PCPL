module operations (
    input [7:0]     operandA, operandB, opA, opB, // 8-ми битные, для знаковости после типа писать слово signed

    output [7:0]    bit_and, bit_or, bit_xor, bit_not,

    output [8:0]    out_sum, out_dif, // доп. бит для избежания переполнения при суммировании
    output [15:0]   out_mul, out_div, out_rem // для умножения не менее суммы разрядностей операндов

    output          bool_and, bool_or, bool_not

    output          rdc_and, rdc_or, rdc_xor
);

assign out_sum = operandA + operandB;
assign out_dif = operandA - operandB;

assign out_mul = operandA * operandB;
assign out_div = operandA / operandB; // присутствует округление до целого в меньш сторону
assign out_rem = operandA % operandB;

// битовые лог. оп.
assign bit_and = opA & opB; // работает как независимое лог. '&/|/^' между соотв. разрядами
assign bit_or = opA | opB;  // 
assign bit_xor = opA ^ opB; //
assign bit_not = ~opA;

// булевые лог. оп.
assign bool_and = opA && opB; // операнды интерп. как лог. знач., если в многоразр. сигнале есть хотя бы один бит 1, интерп. как true
assign bool_orr = opA || opB;
assign bool_not = !opA;

// свертки
assign rdc_and = &opA;
assign rdc_or = |opA;
assign rdc_xor = ^opA;

endmodule