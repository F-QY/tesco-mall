/*==============================================================*/
/* Database: tesco-user                            */
/*==============================================================*/

drop table if exists growth_change_history;

drop table if exists integration_change_history;

drop table if exists users;

drop table if exists user_collect_spu;

drop table if exists user_collect_subject;

drop table if exists user_level;

drop table if exists user_login_log;

drop table if exists user_receive_address;

drop table if exists user_statistics_info;

/*==============================================================*/
/* Table: growth_change_history                             */
/*==============================================================*/
create table growth_change_history
(
   id                   bigint not null auto_increment comment 'id',
   user_id            bigint comment 'user_id',
   create_time          datetime comment 'create_time',
   change_count         int comment '�ı��ֵ������������',
   note                 varchar(0) comment '��ע',
   source_type          tinyint comment '������Դ[0-���1-����Ա�޸�]',
   primary key (id)
);

alter table growth_change_history comment '�ɳ�ֵ�仯��ʷ��¼';

/*==============================================================*/
/* Table: integration_change_history                        */
/*==============================================================*/
create table integration_change_history
(
   id                   bigint not null auto_increment comment 'id',
   user_id            bigint comment 'user_id',
   create_time          datetime comment 'create_time',
   change_count         int comment '�仯��ֵ',
   note                 varchar(255) comment '��ע',
   source_tyoe          tinyint comment '��Դ[0->���1->����Ա�޸�;2->�]',
   primary key (id)
);

alter table integration_change_history comment '���ֱ仯��ʷ��¼';

/*==============================================================*/
/* Table: users                                            */
/*==============================================================*/
create table users
(
   id                   bigint not null auto_increment comment 'id',
   level_id             bigint comment '�û��ȼ�id',
   username             char(64) comment '�û���',
   password             varchar(64) comment '����',
   nickname             varchar(64) comment '�ǳ�',
   mobile               varchar(20) comment '�ֻ�����',
   email                varchar(64) comment '����',
   header               varchar(500) comment 'ͷ��',
   gender               tinyint comment '�Ա�',
   birth                date comment '����',
   city                 varchar(500) comment '���ڳ���',
   job                  varchar(255) comment 'ְҵ',
   sign                 varchar(255) comment '����ǩ��',
   source_type          tinyint comment '�û���Դ',
   integration          int comment '����',
   growth               int comment '�ɳ�ֵ',
   status               tinyint comment '����״̬',
   create_time          datetime comment 'ע��ʱ��',
   primary key (id)
);

alter table users comment '�û�';

/*==============================================================*/
/* Table: user_collect_spu                                */
/*==============================================================*/
create table user_collect_spu
(
   id                   bigint not null comment 'id',
   user_id            bigint comment '�û�id',
   spu_id               bigint comment 'spu_id',
   spu_name             varchar(500) comment 'spu_name',
   spu_img              varchar(500) comment 'spu_img',
   create_time          datetime comment 'create_time',
   primary key (id)
);

alter table user_collect_spu comment '�û��ղص���Ʒ';

/*==============================================================*/
/* Table: user_collect_subject                            */
/*==============================================================*/
create table user_collect_subject
(
   id                   bigint not null auto_increment comment 'id',
   subject_id           bigint comment 'subject_id',
   subject_name         varchar(255) comment 'subject_name',
   subject_img          varchar(500) comment 'subject_img',
   subject_urll         varchar(500) comment '�url',
   primary key (id)
);

alter table user_collect_subject comment '�û��ղص�ר��';

/*==============================================================*/
/* Table: user_level                                      */
/*==============================================================*/
create table user_level
(
   id                   bigint not null auto_increment comment 'id',
   name                 varchar(100) comment '�ȼ�����',
   growth_point         int comment '�ȼ���Ҫ�ĳɳ�ֵ',
   default_status       tinyint comment '�Ƿ�ΪĬ�ϵȼ�[0->���ǣ�1->��]',
   free_freight_point   decimal(18,4) comment '���˷ѱ�׼',
   comment_growth_point int comment 'ÿ�����ۻ�ȡ�ĳɳ�ֵ',
   priviledge_free_freight tinyint comment '�Ƿ���������Ȩ',
   priviledge_user_price tinyint comment '�Ƿ����û��۸���Ȩ',
   priviledge_birthday  tinyint comment '�Ƿ���������Ȩ',
   note                 varchar(255) comment '��ע',
   primary key (id)
);

alter table user_level comment '�û��ȼ�';

/*==============================================================*/
/* Table: user_login_log                                  */
/*==============================================================*/
create table user_login_log
(
   id                   bigint not null auto_increment comment 'id',
   user_id            bigint comment 'user_id',
   create_time          datetime comment '����ʱ��',
   ip                   varchar(64) comment 'ip',
   city                 varchar(64) comment 'city',
   login_type           tinyint(1) comment '��¼����[1-web��2-app]',
   primary key (id)
);

alter table user_login_log comment '�û���¼��¼';

/*==============================================================*/
/* Table: user_receive_address                            */
/*==============================================================*/
create table user_receive_address
(
   id                   bigint not null auto_increment comment 'id',
   user_id            bigint comment 'user_id',
   name                 varchar(255) comment '�ջ�������',
   phone                varchar(64) comment '�绰',
   post_code            varchar(64) comment '��������',
   province             varchar(100) comment 'ʡ��/ֱϽ��',
   city                 varchar(100) comment '����',
   region               varchar(100) comment '��',
   detail_address       varchar(255) comment '��ϸ��ַ(�ֵ�)',
   areacode             varchar(15) comment 'ʡ��������',
   default_status       tinyint(1) comment '�Ƿ�Ĭ��',
   primary key (id)
);

alter table user_receive_address comment '�û��ջ���ַ';

/*==============================================================*/
/* Table: user_statistics_info                            */
/*==============================================================*/
create table user_statistics_info
(
   id                   bigint not null auto_increment comment 'id',
   user_id            bigint comment '�û�id',
   consume_amount       decimal(18,4) comment '�ۼ����ѽ��',
   coupon_amount        decimal(18,4) comment '�ۼ��Żݽ��',
   order_count          int comment '��������',
   coupon_count         int comment '�Ż�ȯ����',
   comment_count        int comment '������',
   return_order_count   int comment '�˻�����',
   login_count          int comment '��¼����',
   attend_count         int comment '��ע����',
   fans_count           int comment '��˿����',
   collect_product_count int comment '�ղص���Ʒ����',
   collect_subject_count int comment '�ղص�ר������',
   collect_comment_count int comment '�ղص���������',
   invite_friend_count  int comment '�������������',
   primary key (id)
);

alter table user_statistics_info comment '�û�ͳ����Ϣ';
