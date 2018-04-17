function Snn = normal_stress(Se, n);

    Snn = Se(1)*n(1)^2 + 2*Se(3)*n(1)*n(2) + Se(2)*n(2)^2;

end
