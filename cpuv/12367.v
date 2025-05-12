module fsk_iface_mchester(
    input sqwv, 
    input fsk_in, 
    input manual, 
    output reg fsk_out, 
    output reg fsk_out_trigger, 
    output reg done 
    );
    integer count_0s, count_0secs, count_1s, count_all; 
    reg [2:0] occurence; 
    reg ready_or_not; 
    reg [1:0] ready_preamble_stage; 
    initial begin
        ready_or_not = 0; 
        ready_preamble_stage = 0; 
        count_0s = 0; 
        count_1s = 0; 
        count_all = 0; 
        fsk_out_trigger = 0; 
        fsk_out = 0; 
        occurence = 0; 
        done = 0; 
     end
    always @(posedge sqwv) begin
        if (manual == 1) begin 
            ready_or_not <= 0;
            ready_preamble_stage <= 0;
            count_0s <= 0;
            count_1s <= 0;
            count_all <= 0;
            fsk_out <= 0;
            fsk_out_trigger <= 0;
            occurence <= 0;
            done <= 0;
        end
        else if (ready_or_not == 0) begin 
            if (ready_preamble_stage == 0 && fsk_in == 1) begin 
                count_1s <= count_1s + 1;
                ready_preamble_stage <= 1;
            end
        else if (ready_or_not == 1 && count_0secs == 152) begin 
            ready_or_not <= 0;
            ready_preamble_stage <= 0;
            count_1s <= 0;
            count_0s <= 0;
            count_0secs <= 0;
            count_all <= 0;
            done <= 1;
        end
        else begin 
        end
    end
endmodule