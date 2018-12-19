%% ���C���t�@�C��:
% ��ԕϐ��Ƒ���ϐ��𗣎U������2���ԃ��f��������.

clear;
clear global;
close all;
format short;

%% *** �J���u���[�V���� ***
beta  = 0.985.^30;     % �������q
gamma = 2.0;           % ���ΓI�댯���x
rent  = 1.025.^30-1.0; % �����q��
%======================================

% *** �p�����[�^ ***
nw    =  10;   % �����O���b�h�̐�
w_max = 1.0;   % �����O���b�h�̍ő�l
w_min = 0.1;   % �����O���b�h�̍ŏ��l
na    =  40;   % ���~�O���b�h�̐�
a_max = 1.0;   % ���~�O���b�h�̍ő�l
a_min = 0.025; % ���~�O���b�h�̍ŏ��l
%==================================

tic % �v�Z���Ԃ��J�E���g�J�n

disp(' ');
disp('-+-+-+- Solve two period model using discretization -+-+-+-');

%% �O���b�h�|�C���g���v�Z

grid_w = linspace(w_min, w_max, nw)';
grid_a = linspace(a_min, a_max, na)';


%% 2���̌��p�֐����v���b�g���Ă݂�(�ŏI�I�Ȍ��ʂɂ͕s�v�Ȍv�Z)

util2 = beta.*CRRA((1.0+rent).*grid_a, gamma);

% ���p�֐��̐}��`��
figure;
plot(grid_a,util2,'-o','color','blue','MarkerEdgeColor','b','MarkerSize',12,'linewidth',3);
xlabel('�V�N���̎��Y','Fontsize',16);
ylabel('�V�N���̌��p','Fontsize',16);
xlim([a_min,a_max]);
set(gca,'Fontsize',16);
grid on;
saveas (gcf,'Fig2_utility_at_period2.eps','epsc2');

%% ������(w,a)�̑g�ݍ��킹�ɂ��Đ��U���p���v�Z

obj = zeros(na, nw);

for i = 1:nw
    for j = 1:na
        cons = grid_w(i) - grid_a(j);
        if cons > 0.0
            obj(j, i) = CRRA(cons, gamma) + beta*CRRA((1.0+rent)*grid_a(j), gamma);
        else
            % ������l�̏ꍇ�A�y�i���e�B��^���Ă��̒l���I�΂�Ȃ��悤�ɂ���
            obj(j, i) = -10000.0;
        end
    end
end

%% ���p���ő�ɂ��鑀��ϐ���T���o���F����֐�

pol = zeros(nw,1);

% �ew�ɂ��Đ��U���p���ő�ɂ���a��T��
for i = 1:nw
    [maxv, maxl] = max(obj(:,i));
    pol(i) = grid_a(maxl);
end

toc % �v�Z���Ԃ��J�E���g�I��

%% �}��`��

figure;
plot(grid_a,obj(:, 5), '-o', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3); hold('on');
plot(grid_a,obj(:, 8), '-.^', 'color', 'green', 'MarkerEdgeColor', 'g', 'MarkerSize', 12, 'linewidth', 3);
plot(grid_a,obj(:, 10), '--s', 'color', 'red', 'MarkerEdgeColor', 'r', 'MarkerSize', 12, 'linewidth', 3); hold('off');
xlabel('��N���̒��~(�V�N���̎��Y)�Fa', 'Fontsize', 16);
ylabel('���U���p�FU(c_{1},c_{2})', 'Fontsize', 16);
xlim([0.0, a_max]);
ylim([-10.0, 0.0]);
set(gca,'Fontsize', 16);
legend('w=0.5', 'w=0.8', 'w=1.0', 'Location', 'NorthEast');
grid on;
saveas (gcf,'Fig2_utility_max.eps','epsc2');

figure;
plot(grid_w,pol, '-o', 'color', 'blue', 'MarkerEdgeColor', 'b', 'MarkerSize', 12, 'linewidth', 3);
xlabel('��N���̏����Fw', 'Fontsize', 16);
ylabel('��N���̒��~�Fa', 'Fontsize', 16);
xlim([0, 1]);
ylim([0, 0.5]);
set(gca, 'Fontsize', 16);
grid on;
saveas (gcf,'Fig2_pol_discr.eps','epsc2');

return;
