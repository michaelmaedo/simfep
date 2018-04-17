function Snn = princ_stress(Se_elast)
    S = [Se_elast(1), Se_elast(3);
         Se_elast(3), Se_elast(2)];
    Sp = eig(S);
    Sp = sort(Sp);
    Snn = Sp(2);
end
