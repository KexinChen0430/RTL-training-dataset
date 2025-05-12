module)
    output reg [31:0] dout,     
    output            dout_vld, 
    input             dout_re,   
    output            last_DW
);
    reg  [15:0] hr; 
    reg         hr_full;
    reg   [1:0] dout_vld_r;
    reg         din_av_safe_r;
    reg         din_re_r;
    wire  [1:0] dav_in = {2{din_av_safe_r}} & dm;
    wire  [1:0] drd_in = {2{din_re}} & dm;
    wire [15:0] debug_din_low =  din[15: 0];
    wire [15:0] debug_din_high = din[31:16];
    wire [15:0] debug_dout_low =  dout[15: 0];
    wire [15:0] debug_dout_high = dout[31:16];
    wire        more_words_avail = |dav_in || hr_full;
    wire  [1:0] next_or_empty = {2{dout_re}} | ~dout_vld_r;
    wire room_for2 = dout_re || (!(&dout_vld_r) && !hr_full) || !(|dout_vld_r);
    wire room_for1 = dout_re || !hr_full || !(&dout_vld_r);
    reg              slow_down; 
    reg              slow_dav;  
    reg              last_DW_r;
    reg              last_dw_sent;
    wire             no_new_data_w;
    reg        [1:0] no_new_data_r;
    assign din_re = din_av_safe_r && (!(|dm) || room_for2 || (room_for1 && !(&dm)));
    assign dout_vld = (!slow_down && (&dout_vld_r)) || slow_dav;
    assign last_DW = last_DW_r;
    assign flushed = last_DW_r && dout_re;
    assign no_new_data_w = !din_av && !hr_full;
    always @ (posedge clk) begin
        din_re_r <= din_re;
        if (rst) din_av_safe_r <= 0;
        else     din_av_safe_r <= din_av && (din_avm || (!din_re && !din_re_r));
        if (rst)                   dout_vld_r[0] <= 0;
        else if (next_or_empty[0]) dout_vld_r[0] <= hr_full || (din_re && (|dm));
        if (next_or_empty[0]) begin
            if (hr_full)        dout[15: 0] <= hr;
            else if (din_re) begin
                if (dm[0])      dout[15: 0] <= din[15: 0];
                else if (dm[1]) dout[15: 0] <= din[31:16];
            end
        end
        if (rst)                   dout_vld_r[1] <= 0;
        else if (next_or_empty[1]) dout_vld_r[1] <= next_or_empty[0]?
                                                     (din_re && ((hr_full &&(|dm)) || (&dm))) :
                                                     (hr_full || (din_re && (|dm)));
        if (next_or_empty[1])   begin
            if (next_or_empty[0]) begin
                if (din_re) begin
                    if      (hr_full && dm[0])             dout[31:16] <= din[15: 0];
                    else if (dm[1] && (!hr_full || dm[0])) dout[31:16] <= din[31:16];
                end
            end else begin
                if (hr_full)        dout[31:16] <= hr;
                else if (din_re) begin
                    if (dm[0])      dout[31:16] <= din[15: 0];
                    else if (dm[1]) dout[31:16] <= din[31:16];
                end
            end
        end
        if      (rst)                               hr_full <= 0;
        else if (((&next_or_empty) && !(&drd_in)) ||
                 ((|next_or_empty) && !(|drd_in)))  hr_full <= 0;
        else if (((&drd_in) && !(&next_or_empty)) ||
                 ((|drd_in) && !(|next_or_empty)))  hr_full <= 1;
        if      (drd_in[1]) hr <=  din[31:16];
        else if (drd_in[0]) hr <=  din[15: 0];
        if (rst || !flushing) slow_down <= 0;
        else if (!din_avm_w)  slow_down <= 1;
        if (rst || !flushing || last_dw_sent) slow_dav <= 0;
        else                    slow_dav <=  !dout_re && !last_dw_sent && ((!next_or_empty[1] && more_words_avail) || last_DW_r);
        if      (rst || !flushing)     last_dw_sent <= 0;
        else if (last_DW_r && dout_re) last_dw_sent <= 1;
        no_new_data_r <= {no_new_data_r[0], no_new_data_w};
        if      (rst || !flushing)                               last_DW_r <= 0;
        else if (slow_down && no_new_data_w && (&no_new_data_r)) last_DW_r <= 1;
        else if (dout_re)                                        last_DW_r <= 0;
    end
endmodule