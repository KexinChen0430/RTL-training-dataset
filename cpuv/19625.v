module instance name issues.
  test name_gbi(out[0]);
  generate
    begin: name_gbi
      assign out[0] = 0;
    end
  endgenerate
  initial begin: name_gbb
    $display("FAILED in name_gbb");
  end
  generate
    begin: name_gbb
      assign out[0] = 0;
    end
  endgenerate
  event name_gbe;
  generate
    begin: name_gbe
      assign out[0] = 0;
    end
  endgenerate
  generate
    begin: name_gbgb
      assign out[0] = 0;
    end
  endgenerate
  generate
    begin: name_gbgb
      assign out[0] = 0;
    end
  endgenerate
  initial $display("FAILED");
endmodule