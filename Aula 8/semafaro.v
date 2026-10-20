module semaforo (
    input wire rst,
    input wire clk_50M,
    output wire [2:0] lights // Ajustado para 3 bits
);

    wire clk_1s;
    wire clear;
    wire top;
    wire [1:0] sel;

    // Divisor de clock / Contador
    // Nota: Se o seu modulo no arquivo counter.v tiver o nome "counter", 
    // troque "clk_1s u0" abaixo por "counter u0"
    clk_1s u0 (
        .rst(rst),
        .clk_50M(clk_50M),
        .clk_out(clk_1s)
    );

    // Maquina de Estados
    semaforo_fsm u1 (
        .rst(rst),
        .clk(clk_1s),
        .clear(clear),
        .sel(sel),
        .top(top),
        .lights(lights)
    );

    // Datapath (Nome corrigido: semaforo_datapath)
    semaforo_datapath u2 (
        .clk(clk_1s),
        .clear(clear),
        .sel(sel),
        .top(top)
    );

endmodule