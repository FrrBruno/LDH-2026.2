`define STATE_RED_LOAD    3'd0
`define STATE_RED         3'd1
`define STATE_YELLOW_LOAD 3'd2
`define STATE_YELLOW      3'd3
`define STATE_GREEN_LOAD  3'd4
`define STATE_GREEN       3'd5

module semaforo_fsm (
    input wire clk,
    input wire rst,
    // Sinal de estado vindo do datapath
    input wire top,
    // Sinais de controle indo para o datapath
    output reg clear,
    output reg [1:0] sel,
    // Saidas de controle para os LEDs do semaforo
    output reg [2:0] lights
);

    reg [2:0] state;
    reg [2:0] nextState;

    // Registrador de Estado
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= `STATE_RED_LOAD;
        else
            state <= nextState;
    end

    // Logica do proximo estado
    always @(*) begin
        case (state)
            `STATE_RED_LOAD: begin
                nextState = `STATE_RED;
            end

            `STATE_RED: begin
                if (top)
                    nextState = `STATE_GREEN_LOAD;
                else
                    nextState = `STATE_RED;
            end

            `STATE_GREEN_LOAD: begin
                nextState = `STATE_GREEN;
            end

            `STATE_GREEN: begin
                if (top)
                    nextState = `STATE_YELLOW_LOAD;
                else
                    nextState = `STATE_GREEN;
            end

            `STATE_YELLOW_LOAD: begin
                nextState = `STATE_YELLOW;
            end

            `STATE_YELLOW: begin
                if (top)
                    nextState = `STATE_RED_LOAD;
                else
                    nextState = `STATE_YELLOW;
            end

            default: begin
                nextState = `STATE_RED_LOAD;
            end
        endcase
    end

    // Logica das saidas combinacionais
    always @(*) begin
        // Valores padrao para evitar a criacao de latches
        clear  = 1'b0;
        sel    = 2'd0;
        lights = 3'b000;

        case (state)
            `STATE_RED_LOAD: begin
                clear  = 1'b1;
                sel    = 2'd0;
                lights = 3'b100; // Vermelho
            end

            `STATE_RED: begin
                clear  = 1'b0;
                sel    = 2'd0;
                lights = 3'b100; // Vermelho
            end

            `STATE_GREEN_LOAD: begin
                clear  = 1'b1;
                sel    = 2'd2;
                lights = 3'b001; // Verde
            end

            `STATE_GREEN: begin
                clear  = 1'b0;
                sel    = 2'd2;
                lights = 3'b001; // Verde
            end

            `STATE_YELLOW_LOAD: begin
                clear  = 1'b1;
                sel    = 2'd1;
                lights = 3'b010; // Amarelo
            end

            `STATE_YELLOW: begin
                clear  = 1'b0;
                sel    = 2'd1;
                lights = 3'b010; // Amarelo
            end

            default: begin
                clear  = 1'b0;
                sel    = 2'd0;
                lights = 3'b000;
            end
        endcase
    end

endmodule