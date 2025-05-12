module outputs(
    output wire [3:0] outport_encoder
);
assign outport_encoder =
    {
        outport_encoder_vec[0] || outport_encoder_vec[1] ||
        outport_encoder_vec[2] || outport_encoder_vec[3] ||
        outport_encoder_vec[4],
        outport_encoder_vec[0] ?
            3'd0 :
            (outport_encoder_vec[1] ?
                3'd1 :
                (outport_encoder_vec[2] ?
                    3'd2 :
                    (outport_encoder_vec[3] ? 3'd3 : 3'd4)))
    };
endmodule