module tlb(page_in, miss, found,
           clk, enable, frame_out,
           rw_index, r_page, r_frame,
           w_enable, w_page, w_frame);