function p_over_lx = find_p(delta,h, param)
    p_over_lx = param.E_in*delta / (param.omega * param.eta * sin(param.k * h));
end