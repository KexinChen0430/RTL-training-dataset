module FSM_Semaforo(
    input clk, reset, Sensor_Sync, WR, Prog_Sync, expire,
    output WR_Reset, Rm, Ym, Gm, Rs, Ys, Gs, Walk, start_timer,
    output reg [1:0] interval
);
    reg [3:0] state;
    parameter STATE_0 = 0;
    parameter STATE_1 = 1;
    parameter STATE_2 = 2;
    parameter STATE_3 = 3;
    parameter STATE_4 = 4;
    parameter STATE_5 = 5;
    parameter STATE_6 = 6;
    parameter STATE_7 = 7;
    parameter STATE_8 = 8;
    parameter STATE_9 = 9;
    parameter STATE_10 = 10;
    parameter STATE_11 = 11;
    parameter STATE_12 = 12;
    parameter STATE_13 = 13;
    parameter STATE_14 = 14;
    parameter STATE_15 = 15;
    always@(posedge clk or posedge reset)
    begin
        if (reset || Prog_Sync)
        begin
            state <= STATE_0;
        end
        else
        begin
            case(state)
            endcase
        end
    end
    assign start_timer = (state == STATE_1 || state == STATE_3 || state == STATE_5 || state == STATE_7 || state == STATE_9 || state == STATE_11 || state == STATE_13 || state == STATE_15);
    assign Rm = (state == STATE_7 || state == STATE_9 || state == STATE_13 || state == STATE_15);
    assign Ym = (state == STATE_5);
    assign Gm = (state == STATE_1 || state == STATE_3 || state == STATE_11);
    assign Rs = (state == STATE_1 || state == STATE_3 || state == STATE_5 || state == STATE_11 || state == STATE_13);
    assign Ys = (state == STATE_9);
    assign Gs = (state == STATE_7 || state == STATE_15);
    assign Walk = (state == STATE_13);
    assign WR_Reset = (state == STATE_12);
endmodule