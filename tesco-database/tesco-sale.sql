/*==============================================================*/
/* Database: tesco-sale                                           */
/*==============================================================*/

drop table if exists coupon;

drop table if exists coupon_history;

drop table if exists coupon_spu_category_relation;

drop table if exists coupon_spu_relation;

drop table if exists home_adv;

drop table if exists home_subject;

drop table if exists home_subject_spu;

drop table if exists user_price;

drop table if exists seckill_promotion;

drop table if exists seckill_session;

drop table if exists seckill_sku_notice;

drop table if exists seckill_sku_relation;

drop table if exists sku_full_reduction;

drop table if exists sku_ladder;

drop table if exists spu_bounds;

/*==============================================================*/
/* Table: coupon                                            */
/*==============================================================*/
create table coupon
(
   id                   bigint not null auto_increment comment 'id',
   coupon_type          tinyint(1) comment '�Żݾ�����[0->ȫ����ȯ��1->�û���ȯ��2->������ȯ��3->ע����ȯ]',
   coupon_img           varchar(2000) comment '�Ż�ȯͼƬ',
   coupon_name          varchar(100) comment '�Żݾ�����',
   num                  int comment '����',
   amount               decimal(18,4) comment '���',
   per_limit            int comment 'ÿ����������',
   min_point            decimal(18,4) comment 'ʹ���ż�',
   start_time           datetime comment '��ʼʱ��',
   end_time             datetime comment '����ʱ��',
   use_type             tinyint(1) comment 'ʹ������[0->ȫ��ͨ�ã�1->ָ�����ࣻ2->ָ����Ʒ]',
   note                 varchar(200) comment '��ע',
   publish_count        int(11) comment '��������',
   use_count            int(11) comment '��ʹ������',
   receive_count        int(11) comment '��ȡ����',
   enable_start_time    datetime comment '������ȡ�Ŀ�ʼ����',
   enable_end_time      datetime comment '������ȡ�Ľ�������',
   code                 varchar(64) comment '�Ż���',
   user_level         tinyint(1) comment '������ȡ���û��ȼ�[0->���޵ȼ�������-��Ӧ�ȼ�]',
   publish              tinyint(1) comment '����״̬[0-δ������1-�ѷ���]',
   primary key (id)
);

alter table coupon comment '�Ż�ȯ��Ϣ';

/*==============================================================*/
/* Table: coupon_history                                    */
/*==============================================================*/
create table coupon_history
(
   id                   bigint not null auto_increment comment 'id',
   coupon_id            bigint comment '�Ż�ȯid',
   user_id            bigint comment '�û�id',
   user_nick_name     varchar(64) comment '�û�����',
   get_type             tinyint(1) comment '��ȡ��ʽ[0->��̨���ͣ�1->������ȡ]',
   create_time          datetime comment '����ʱ��',
   use_type             tinyint(1) comment 'ʹ��״̬[0->δʹ�ã�1->��ʹ�ã�2->�ѹ���]',
   use_time             datetime comment 'ʹ��ʱ��',
   order_id             bigint comment '����id',
   order_sn             bigint comment '������',
   primary key (id)
);

alter table coupon_history comment '�Ż�ȯ��ȡ��ʷ��¼';

/*==============================================================*/
/* Table: coupon_spu_category_relation                      */
/*==============================================================*/
create table coupon_spu_category_relation
(
   id                   bigint not null auto_increment comment 'id',
   coupon_id            bigint comment '�Ż�ȯid',
   category_id          bigint comment '��Ʒ����id',
   category_name        varchar(64) comment '��Ʒ��������',
   primary key (id)
);

alter table coupon_spu_category_relation comment '�Ż�ȯ�������';

/*==============================================================*/
/* Table: coupon_spu_relation                               */
/*==============================================================*/
create table coupon_spu_relation
(
   id                   bigint not null auto_increment comment 'id',
   coupon_id            bigint comment '�Ż�ȯid',
   spu_id               bigint comment 'spu_id',
   spu_name             varchar(255) comment 'spu_name',
   primary key (id)
);

alter table coupon_spu_relation comment '�Ż�ȯ���Ʒ����';

/*==============================================================*/
/* Table: home_adv                                          */
/*==============================================================*/
create table home_adv
(
   id                   bigint not null auto_increment comment 'id',
   name                 varchar(100) comment '����',
   pic                  varchar(500) comment 'ͼƬ��ַ',
   start_time           datetime comment '��ʼʱ��',
   end_time             datetime comment '����ʱ��',
   status               tinyint(1) comment '״̬',
   click_count          int comment '�����',
   url                  varchar(500) comment '����������ӵ�ַ',
   note                 varchar(500) comment '��ע',
   sort                 int comment '����',
   publisher_id         bigint comment '������',
   auth_id              bigint comment '�����',
   primary key (id)
);

alter table home_adv comment '��ҳ�ֲ����';

/*==============================================================*/
/* Table: home_subject                                      */
/*==============================================================*/
create table home_subject
(
   id                   bigint not null auto_increment comment 'id',
   name                 varchar(200) comment 'ר������',
   title                varchar(255) comment 'ר�����',
   sub_title            varchar(255) comment 'ר�⸱����',
   status               tinyint(1) comment '��ʾ״̬',
   url                  varchar(500) comment '��������',
   sort                 int comment '����',
   img                  varchar(500) comment 'ר��ͼƬ��ַ',
   primary key (id)
);

alter table home_subject comment '��ҳר���jd��ҳ����ܶ�ר�⣬ÿ��ר�������µ�ҳ�棬չʾר����Ʒ��Ϣ��';

/*==============================================================*/
/* Table: home_subject_spu                                  */
/*==============================================================*/
create table home_subject_spu
(
   id                   bigint not null auto_increment comment 'id',
   name                 varchar(200) comment 'ר������',
   subject_id           bigint comment 'ר��id',
   spu_id               bigint comment 'spu_id',
   sort                 int comment '����',
   primary key (id)
);

alter table home_subject_spu comment 'ר����Ʒ';

/*==============================================================*/
/* Table: user_price                                      */
/*==============================================================*/
create table user_price
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'sku_id',
   user_level_id      bigint comment '�û��ȼ�id',
   user_level_name    varchar(100) comment '�û��ȼ���',
   user_price         decimal(18,4) comment '�û���Ӧ�۸�',
   add_other            tinyint(1) comment '�ɷ���������Ż�[0-���ɵ����Żݣ�1-�ɵ���]',
   primary key (id)
);

alter table user_price comment '��Ʒ�û��۸�';

/*==============================================================*/
/* Table: seckill_promotion                                 */
/*==============================================================*/
create table seckill_promotion
(
   id                   bigint not null auto_increment comment 'id',
   title                varchar(255) comment '�����',
   start_time           datetime comment '��ʼ����',
   end_time             datetime comment '��������',
   status               tinyint comment '������״̬',
   create_time          datetime comment '����ʱ��',
   user_id              bigint comment '������',
   primary key (id)
);

alter table seckill_promotion comment '��ɱ�';

/*==============================================================*/
/* Table: seckill_session                                   */
/*==============================================================*/
create table seckill_session
(
   id                   bigint not null auto_increment comment 'id',
   name                 varchar(200) comment '��������',
   start_time           datetime comment 'ÿ�տ�ʼʱ��',
   end_time             datetime comment 'ÿ�ս���ʱ��',
   status               tinyint(1) comment '����״̬',
   create_time          datetime comment '����ʱ��',
   primary key (id)
);

alter table seckill_session comment '��ɱ�����';

/*==============================================================*/
/* Table: seckill_sku_notice                                */
/*==============================================================*/
create table seckill_sku_notice
(
   id                   bigint not null auto_increment comment 'id',
   user_id            bigint comment 'user_id',
   sku_id               bigint comment 'sku_id',
   session_id           bigint comment '�����id',
   subcribe_time        datetime comment '����ʱ��',
   send_time            datetime comment '����ʱ��',
   notice_type          tinyint(1) comment '֪ͨ��ʽ[0-���ţ�1-�ʼ�]',
   primary key (id)
);

alter table seckill_sku_notice comment '��ɱ��Ʒ֪ͨ����';

/*==============================================================*/
/* Table: seckill_sku_relation                              */
/*==============================================================*/
create table seckill_sku_relation
(
   id                   bigint not null auto_increment comment 'id',
   promotion_id         bigint comment '�id',
   promotion_session_id bigint comment '�����id',
   sku_id               bigint comment '��Ʒid',
   seckill_price        decimal comment '��ɱ�۸�',
   seckill_count        decimal comment '��ɱ����',
   seckill_limit        decimal comment 'ÿ���޹�����',
   seckill_sort         int comment '����',
   primary key (id)
);

alter table seckill_sku_relation comment '��ɱ���Ʒ����';

/*==============================================================*/
/* Table: sku_full_reduction                                */
/*==============================================================*/
create table sku_full_reduction
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'spu_id',
   full_price           decimal(18,4) comment '������',
   reduce_price         decimal(18,4) comment '������',
   add_other            tinyint(1) comment '�Ƿ���������Ż�',
   primary key (id)
);

alter table sku_full_reduction comment '��Ʒ������Ϣ';

/*==============================================================*/
/* Table: sku_ladder                                        */
/*==============================================================*/
create table sku_ladder
(
   id                   bigint not null auto_increment comment 'id',
   sku_id               bigint comment 'spu_id',
   full_count           int comment '������',
   discount             decimal(4,2) comment '����',
   price                decimal(18,4) comment '�ۺ��',
   add_other            tinyint(1) comment '�Ƿ���������Ż�[0-���ɵ��ӣ�1-�ɵ���]',
   primary key (id)
);

alter table sku_ladder comment '��Ʒ���ݼ۸�';

/*==============================================================*/
/* Table: spu_bounds                                        */
/*==============================================================*/
create table spu_bounds
(
   id                   bigint not null auto_increment comment 'id',
   spu_id               bigint,
   grow_bounds          decimal(18,4) comment '�ɳ�����',
   buy_bounds           decimal(18,4) comment '�������',
   work                 tinyint(1) comment '�Ż���Ч���[1111���ĸ�״̬λ�����ҵ���;0 - ���Żݣ��ɳ������Ƿ�����;1 - ���Żݣ���������Ƿ�����;2 - ���Żݣ��ɳ������Ƿ�����;3 - ���Żݣ���������Ƿ����͡�״̬λ0�������ͣ�1�����͡�]',
   primary key (id)
);

alter table spu_bounds comment '��Ʒspu��������';
