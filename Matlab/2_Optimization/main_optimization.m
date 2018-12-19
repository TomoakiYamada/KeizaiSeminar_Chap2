%% ���C���t�@�C��:
% �œK��(�ŏ���)�֐��𗘗p����2���ԃ��f��������.

clear;
clear global;
close all;
format short;

% �O���[�o���ϐ��Fobj_two_period.m�ƕϐ������L
global w beta gamma rent

%% *** �J���u���[�V���� ***
beta  = 0.985.^30;     % �������q
gamma = 2.0;           % ���ΓI�댯���x
rent  = 1.025.^30-1.0; % �����q��
%======================================

% *** �p�����[�^ ***
nw    =  10; % �����O���b�h�̐�
w_max = 1.0; % �����O���b�h�̍ő�l
w_min = 0.1; % �����O���b�h�̍ŏ��l
%================================

%% �œK���֐����g����2���ԃ��f��������

tic % �v�Z���Ԃ��J�E���g�J�n

disp(' ');
disp('-+-+-+- Solve two period model using optimization -+-+-+-');

% �O���b�h�|�C���g���v�Z
grid_w = linspace(w_min, w_max, nw)';

%% fminbnd(�œK���֐��̈��)���g���Č��p�ő剻��������

a_gs = zeros(nw,1);

% �ew�ɂ��ĖړI�֐�(obj_two_period.m���ő�ɂ���a��T��)
for i = 1:nw
    w = grid_w(i);
    % w*0.01��w*2.0�͒T����Ԃ͈̔́F�ڍׂ�"help fminbnd"
    [a_gs(i), fval] = fminbnd(@obj_two_period, w*0.01, w*2.0);
end

toc % �v�Z���Ԃ��J�E���g�I��

%% fminsearch(�œK���֐��̈��)���g���Č��p�ő剻��������

a_ss = zeros(nw,1);

for i = 1:nw
    w = grid_w(i);
    % 0.0�͏����l�F�ڍׂ�"help fminsearch"
    [a_ss(i), fval] = fminsearch( @obj_two_period, 0.0);
end

toc % �v�Z���Ԃ��J�E���g�I��

%% �}��`��

figure;
plot(grid_w, a_gs, '-o', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3); hold('on');
plot(grid_w, a_ss, '--d', 'color', 'red', 'MarkerEdgeColor', 'r', 'MarkerSize', 12, 'linewidth', 3); hold('off');
xlabel('��N���̏����Fw', 'Fontsize', 16);
ylabel('��N���̒��~�Fa', 'Fontsize', 16);
xlim([0, w_max]);
ylim([0, 0.5]);
legend('fminbnd','fminsearch','Location','NorthWest');
set(gca, 'Fontsize', 16);
grid on;
saveas (gcf, 'Fig2_optimization_comp.eps', 'epsc2');

figure;
plot(grid_w, a_ss, '-o', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3);
xlabel('��N���̏����Fw', 'Fontsize', 16);
ylabel('��N���̒��~�Fa', 'Fontsize', 16);
xlim([0, w_max]);
ylim([0, 0.5]);
set(gca, 'Fontsize', 16);
grid on;
saveas (gcf, 'Fig2_optimization.eps', 'epsc2');

%% ��͓I��

coef1 = (beta*(1+rent))^(-1./gamma);
coef2 = 1.0/(1.0+coef1*(1+rent));
a_cfs = coef2.*grid_w;

figure;
plot(grid_w, a_cfs, '-', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3);
xlabel('��N���̏���', 'Fontsize', 16);
ylabel('��N���̒��~', 'Fontsize', 16);
xlim([w_min, w_max]);
ylim([0, 0.5]);
set(gca, 'Fontsize', 16);
grid on;
saveas (gcf,'Fig2_closed_form.eps','epsc2');

return;
