module top 

// описание элементов
(
    input           clk,
    input   [9:0]   a, // объявление многоразрядного входного порта
    input           b,
    output  [3:0]   q // объявл. мн.-разр. вых. порта
);
    // логический тип данных
    //logic c; --> однобитный, т.е. однопроводная шина

    // logic [3:0] c; // --> четырехпроводные шины (задание многоразрядных проводов)
    
    //logic [3:0] c, d; // разновидность объявления проводов

    logic [3:0] c;
    logic [8:0] d [0:24]; // массив проводов (условно массив из 25-ти 9-разрядных шин)

    //присвоение, т.е. приравнивание с чему-то (в данном случае лог. & от а и b)
    //assign c = a & b;

    //assign c = d;

    //assign q = d[3]; // присваивание определенного бита

    //assign c = d[6:3]; // присваивание диапазона разрядов

    assign q = d[c]; //назначение номера бита, определяемого шиной (коммутатор/мультиплексер)

// форматы представления данных

    wire [10:0] a = 7;          // 7 интерпретируется как 32-битное десятичное число, которое обрежется до 11 разрядов
    wire [10:0] b = 'd7;        // интерпретируется как десятичное число 11-битное, т.е. без указание разр., оно соотв разрядности сигнала
    wire [10:0] b = 11'd7;      // явное определение, формата, разрядности и значения (обычно исп. именно оно)
    wire [3: 0] c = 4'b0101;    // 4-х битное двоичное число
    wire [7: 0] d = 8'h7B;      // 8-ми битное шестнадцатеричное число 7B
    wire [47:0] e = 48'hEFCA7E  // 48-ми битное шестнадцатеричное число
    
    wire signed [10:0] b = -11'd7; // знаковое 11-ти битное отриц. десятичное число

// операции
    // {}  -- конкатенация
    assign [1:0] c = {a, b}; // объединение сигналов/шин в единую сущность (присоединение а и b к с)
    // + - * /  -- арифм. опер.
    // %  -- модуль
    // > >= < <=  -- отношения
    // !  -- логич. отриц.
    // && ||  -- логич. и/или
    // == != -- логич. рав-во/нерав-во
    // === !== -- идентичность/неидентичность
    // ~ -- побитовая инверсия
    // & -- побитовое и
    // | -- побитовое или
//осн. операции
    // << сдвиг влево
    // >> сдвиг вправо
    // <<< арифм. сдвиг влево
    // >>> арифм. сдвиг вправо
    // ?: тернарн. опер.

// процедурный блок always
    always @(*) begin // в скобках условие/событие, при котором срабатывает схема; '*' обозначает любое изменение сигнала
        q = ~a[7:4]; // опис. функционирование сигналов
    end

    always_comb begin
        // всегда работает; внутри блока always можно проводить несколько операций
        if (d) begin // могут быть вложенными
            c = a & b;
        end
        else begin
            c = a | b;
        end
        case (option)
            0: e = a;
            1: e = b;
            2: e = c;
            3: e = d;
            default: e = d;
        endcase
    end

// ветвление 
// (if-else)
if (d) begin // могут быть вложенными
    c = a & b;
end
else begin
    c = a | b;
end
// (case)
case (option)
    0: e = a;
    1: e = b;
    2: e = c;
    3: e = d;
    4: begin
        c = d;
        e = c;
    end
    default: e = d;
endcase
endmodule


/* порядок запуска скриптов:
    скрипт 6: выбор платы, конфигурация окружения
    скрипт 3: синтезирование для нужной платы в прошивку, программирует ПЛИС стенд

