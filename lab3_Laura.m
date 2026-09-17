clear all
clc

x=0.1:1/22:1;
d=((1+0.6*sin(2*pi*x/0.7))+0.3*sin(2*pi*x))/2;

c_1=0.2;
r_1=0.15;
c_2=0.9;
r_2=0.15;

F_1=exp(-(x-c_1).^2/(2*r_1^2));
F_2=exp(-(x-c_2).^2/(2*r_2^2));

w_1=randn(1);
w_2=randn(1);
w_0=randn(1);

%% mokymas

eta=0.3;
epoch=50;

for mok=1:epoch 
    for i=1:length(x)
        y(i)=F_1(i)*w_1+F_2(i)*w_2+w_0;

        e=d(i)-y(i);

        w_1=w_1+eta*e*F_1(i);
        w_2=w_2+eta*e*F_2(i);
        w_0=w_0+eta*e;
    end
end

figure;
plot(x, d, 'b-o', x, y, 'r-x');
legend('Norimas atsakas (d)', 'Apmokytas tinklo atsakas (y)');
xlabel('x');
ylabel('y');
grid on;
saveas(gcf, 'Apmokymo_metu.png');

%% testavimas

x_test=0.1:1/200:1;
d_test=((1+0.6*sin(2*pi*x_test/0.7))+0.3*sin(2*pi*x_test))/2;

F_1_test=exp(-(x_test-c_1).^2/(2*r_1^2));
F_2_test=exp(-(x_test-c_2).^2/(2*r_2^2));

for i=1:length(x_test)
    y_test(i)=F_1_test(i)*w_1+F_2_test(i)*w_2+w_0;

    e=d_test(i)-y_test(i);
end

figure;
plot(x_test, d_test, 'b-o', x_test, y_test, 'r-x');
legend('Norimas atsakas (d)', 'Apmokyto tinklo atsakas testavime (y)');
xlabel('x');
ylabel('y');
grid on;
saveas(gcf, 'testavimo_metu.png');