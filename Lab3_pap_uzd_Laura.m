clear all
clc

x=0.1:1/22:1;
d=((1+0.6*sin(2*pi*x/0.7))+0.3*sin(2*pi*x))/2;

c_1=randn(1);
r_1=randn(1);
c_2=randn(1);
r_2=randn(1);

w_1=randn(1);
w_2=randn(1);
w_0=randn(1);

%% mokymas

eta=0.1;
eta_rc=0.05;
epoch=15000;

for mok=1:epoch 
    for i=1:length(x)

        F_1=exp(-(x(i)-c_1).^2/(2*r_1^2));
        F_2=exp(-(x(i)-c_2).^2/(2*r_2^2));
        y(i)=F_1*w_1+F_2*w_2+w_0;

        e=d(i)-y(i);

        %kaip atrame labore su gradiantais buvo dabar taip pat cia
        % isvedama isvestine F' pagal c ir r. F'|c= (x-c)/r^2*F; F'|r= (x-c)^2/r^3*F
        
        w_1=w_1+eta*e*F_1;
        w_2=w_2+eta*e*F_2;
        w_0=w_0+eta*e;

        c_1_new=c_1+eta_rc*e*((x(i)-c_1)/r_1^2*F_1);
        c_2_new=c_2+eta_rc*e*((x(i)-c_2)/r_2^2*F_2);

        r_1_new=r_1+eta_rc*e*((x(i)-c_1)^2/r_1^3*F_1);
        r_2_new=r_2+eta_rc*e*((x(i)-c_2)^2/r_2^3*F_2);

        c_1=c_1_new;
        c_2=c_2_new;
        r_1=r_1_new;
        r_2=r_2_new;
    end
end

figure;
plot(x, d, 'b-o', x, y, 'r-x');
legend('Norimas atsakas (d)', 'Apmokytas tinklo atsakas (y)');
xlabel('x');
ylabel('y');
grid on;
saveas(gcf, 'Apmokymo_metu_pap_uzd.png');

%% testavimas

x_test=0.1:1/200:1;
d_test=((1+0.6*sin(2*pi*x_test/0.7))+0.3*sin(2*pi*x_test))/2;

for i=1:length(x_test)

    F_1=exp(-(x_test(i)-c_1).^2/(2*r_1^2));
    F_2=exp(-(x_test(i)-c_2).^2/(2*r_2^2));
    y_test(i)=F_1*w_1+F_2*w_2+w_0;

    e=d_test(i)-y_test(i);
end

figure;
plot(x_test, d_test, 'b-o', x_test, y_test, 'r-x');
legend('Norimas atsakas (d)', 'Apmokyto tinklo atsakas testavime (y)');
xlabel('x');
ylabel('y');
grid on;
saveas(gcf, 'Testavimo_metu_pap_uzd.png');