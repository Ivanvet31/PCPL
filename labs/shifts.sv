module shifts (
    input [7:0] opA, opB,
    output [7:0] out_sll, out_srl, out_sar
);

assign out_sll = opA << opB;

assign out_srl = opA >> opB[2:0] // смещение опр. 3-мя младшими битами второго операнда (смещ. на 3 эквив. делению на 8)

// арифм. сдвиг вправо (сохр. знака числа)
assign out_sar = opA >>> 3;
endmodule