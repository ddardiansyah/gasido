/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     11/13/2018 7:11:15 PM                        */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_HISTORY_MEMPUNYAI_TRANSAKS') then
    alter table HISTORY
       delete foreign key FK_HISTORY_MEMPUNYAI_TRANSAKS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MOBIL_DIKENDARA_SUPIR') then
    alter table MOBIL
       delete foreign key FK_MOBIL_DIKENDARA_SUPIR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PENJADWA_MEMILIKI_MOBIL') then
    alter table PENJADWALAN
       delete foreign key FK_PENJADWA_MEMILIKI_MOBIL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SEWA_SEWA_MOBIL') then
    alter table SEWA
       delete foreign key FK_SEWA_SEWA_MOBIL
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SEWA_SEWA2_PELANGGA') then
    alter table SEWA
       delete foreign key FK_SEWA_SEWA2_PELANGGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSAKS_MELAKUKAN_PELANGGA') then
    alter table TRANSAKSI
       delete foreign key FK_TRANSAKS_MELAKUKAN_PELANGGA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSAKS_MELAYANI_ADMIN') then
    alter table TRANSAKSI
       delete foreign key FK_TRANSAKS_MELAYANI_ADMIN
end if;

drop index if exists ADMIN.ADMIN_PK;

drop table if exists ADMIN;

drop index if exists HISTORY.MEMPUNYAI_FK;

drop index if exists HISTORY.HISTORY_PK;

drop table if exists HISTORY;

drop index if exists MOBIL.DIKENDARAI_FK;

drop index if exists MOBIL.MOBIL_PK;

drop table if exists MOBIL;

drop index if exists PELANGGAN.PELANGGAN_PK;

drop table if exists PELANGGAN;

drop index if exists PENJADWALAN.MEMILIKI_FK;

drop index if exists PENJADWALAN.PENJADWALAN_PK;

drop table if exists PENJADWALAN;

drop index if exists SEWA.SEWA2_FK;

drop index if exists SEWA.SEWA_FK;

drop index if exists SEWA.SEWA_PK;

drop table if exists SEWA;

drop index if exists SUPIR.SUPIR_PK;

drop table if exists SUPIR;

drop index if exists TRANSAKSI.MELAYANI_FK;

drop index if exists TRANSAKSI.MELAKUKAN_FK;

drop index if exists TRANSAKSI.TRANSAKSI_PK;

drop table if exists TRANSAKSI;

/*==============================================================*/
/* Table: ADMIN                                                 */
/*==============================================================*/
create table ADMIN 
(
   ID_ADMIN             char(10)                       not null,
   NAMA                 varchar(50)                    null,
   TLP                  varchar(15)                    null,
   PASSWORD             char(8)                        null,
   ALAMAT_ADMIN         varchar(100)                   null,
   constraint PK_ADMIN primary key (ID_ADMIN)
);

/*==============================================================*/
/* Index: ADMIN_PK                                              */
/*==============================================================*/
create unique index ADMIN_PK on ADMIN (
ID_ADMIN ASC
);

/*==============================================================*/
/* Table: HISTORY                                               */
/*==============================================================*/
create table HISTORY 
(
   ID_TRANSAKSI         integer                        not null,
   ID_SEWA              integer                        null,
   TANGGAL_PINJEM       date                           null,
   TANGGAL_KEMBALI      date                           null,
   JUMLAH_BAYAR         integer                        null,
   constraint PK_HISTORY primary key (ID_TRANSAKSI)
);

/*==============================================================*/
/* Index: HISTORY_PK                                            */
/*==============================================================*/
create unique index HISTORY_PK on HISTORY (
ID_TRANSAKSI ASC
);

/*==============================================================*/
/* Index: MEMPUNYAI_FK                                          */
/*==============================================================*/
create index MEMPUNYAI_FK on HISTORY (
ID_SEWA ASC
);

/*==============================================================*/
/* Table: MOBIL                                                 */
/*==============================================================*/
create table MOBIL 
(
   JENISMOBIL           varchar(10)                    null,
   NOPOL                integer                        not null,
   NIK_SUPIR            integer                        null,
   MERK                 varchar(10)                    null,
   WARNA                varchar(10)                    null,
   TAHUN                integer                        null,
   KODE_MOBIL           char(2)                        null,
   constraint PK_MOBIL primary key (NOPOL)
);

/*==============================================================*/
/* Index: MOBIL_PK                                              */
/*==============================================================*/
create unique index MOBIL_PK on MOBIL (
NOPOL ASC
);

/*==============================================================*/
/* Index: DIKENDARAI_FK                                         */
/*==============================================================*/
create index DIKENDARAI_FK on MOBIL (
NIK_SUPIR ASC
);

/*==============================================================*/
/* Table: PELANGGAN                                             */
/*==============================================================*/
create table PELANGGAN 
(
   ID_PELANGGAN         char(10)                       not null,
   NAMA_LENGKAP         varchar(50)                    null,
   EMAIL                varchar(100)                   null,
   NO_TLP               varchar(15)                    null,
   ALAMAT_PELANGGAN     varchar(75)                    null,
   SANDI                char(8)                        null,
   constraint PK_PELANGGAN primary key (ID_PELANGGAN)
);

/*==============================================================*/
/* Index: PELANGGAN_PK                                          */
/*==============================================================*/
create unique index PELANGGAN_PK on PELANGGAN (
ID_PELANGGAN ASC
);

/*==============================================================*/
/* Table: PENJADWALAN                                           */
/*==============================================================*/
create table PENJADWALAN 
(
   TUJUAN               varchar(10)                    null,
   ALAMAT_PENJEMPUTAN   varchar(100)                   null,
   LAMA_PEMINJAMAN      varchar(10)                    null,
   KODEMOBIL            char(2)                        not null,
   NOPOL                integer                        null,
   constraint PK_PENJADWALAN primary key (KODEMOBIL)
);

/*==============================================================*/
/* Index: PENJADWALAN_PK                                        */
/*==============================================================*/
create unique index PENJADWALAN_PK on PENJADWALAN (
KODEMOBIL ASC
);

/*==============================================================*/
/* Index: MEMILIKI_FK                                           */
/*==============================================================*/
create index MEMILIKI_FK on PENJADWALAN (
NOPOL ASC
);

/*==============================================================*/
/* Table: SEWA                                                  */
/*==============================================================*/
create table SEWA 
(
   NOPOL                integer                        not null,
   ID_PELANGGAN         char(10)                       not null,
   constraint PK_SEWA primary key clustered (NOPOL, ID_PELANGGAN)
);

/*==============================================================*/
/* Index: SEWA_PK                                               */
/*==============================================================*/
create unique clustered index SEWA_PK on SEWA (
NOPOL ASC,
ID_PELANGGAN ASC
);

/*==============================================================*/
/* Index: SEWA_FK                                               */
/*==============================================================*/
create index SEWA_FK on SEWA (
NOPOL ASC
);

/*==============================================================*/
/* Index: SEWA2_FK                                              */
/*==============================================================*/
create index SEWA2_FK on SEWA (
ID_PELANGGAN ASC
);

/*==============================================================*/
/* Table: SUPIR                                                 */
/*==============================================================*/
create table SUPIR 
(
   NIK_SUPIR            integer                        not null,
   NAMA                 varchar(50)                    null,
   EMAIL                varchar(100)                   null,
   NOMER_TLP            varchar(15)                    null,
   ALAMAT_SUPIR         varchar(75)                    null,
   SANDI                char(8)                        null,
   constraint PK_SUPIR primary key (NIK_SUPIR)
);

/*==============================================================*/
/* Index: SUPIR_PK                                              */
/*==============================================================*/
create unique index SUPIR_PK on SUPIR (
NIK_SUPIR ASC
);

/*==============================================================*/
/* Table: TRANSAKSI                                             */
/*==============================================================*/
create table TRANSAKSI 
(
   ID_SEWA              integer                        not null,
   ID_ADMIN             char(10)                       null,
   ID_PELANGGAN         char(10)                       null,
   TGLSEWA              date                           null,
   TGLKEMBALI           date                           null,
   JMLHMOBIL            integer                        null,
   HARGA_MOBIL_PERHARI  integer                        null,
   TOTAL                varchar(50)                    null,
   constraint PK_TRANSAKSI primary key (ID_SEWA)
);

/*==============================================================*/
/* Index: TRANSAKSI_PK                                          */
/*==============================================================*/
create unique index TRANSAKSI_PK on TRANSAKSI (
ID_SEWA ASC
);

/*==============================================================*/
/* Index: MELAKUKAN_FK                                          */
/*==============================================================*/
create index MELAKUKAN_FK on TRANSAKSI (
ID_PELANGGAN ASC
);

/*==============================================================*/
/* Index: MELAYANI_FK                                           */
/*==============================================================*/
create index MELAYANI_FK on TRANSAKSI (
ID_ADMIN ASC
);

alter table HISTORY
   add constraint FK_HISTORY_MEMPUNYAI_TRANSAKS foreign key (ID_SEWA)
      references TRANSAKSI (ID_SEWA)
      on update restrict
      on delete restrict;

alter table MOBIL
   add constraint FK_MOBIL_DIKENDARA_SUPIR foreign key (NIK_SUPIR)
      references SUPIR (NIK_SUPIR)
      on update restrict
      on delete restrict;

alter table PENJADWALAN
   add constraint FK_PENJADWA_MEMILIKI_MOBIL foreign key (NOPOL)
      references MOBIL (NOPOL)
      on update restrict
      on delete restrict;

alter table SEWA
   add constraint FK_SEWA_SEWA_MOBIL foreign key (NOPOL)
      references MOBIL (NOPOL)
      on update restrict
      on delete restrict;

alter table SEWA
   add constraint FK_SEWA_SEWA2_PELANGGA foreign key (ID_PELANGGAN)
      references PELANGGAN (ID_PELANGGAN)
      on update restrict
      on delete restrict;

alter table TRANSAKSI
   add constraint FK_TRANSAKS_MELAKUKAN_PELANGGA foreign key (ID_PELANGGAN)
      references PELANGGAN (ID_PELANGGAN)
      on update restrict
      on delete restrict;

alter table TRANSAKSI
   add constraint FK_TRANSAKS_MELAYANI_ADMIN foreign key (ID_ADMIN)
      references ADMIN (ID_ADMIN)
      on update restrict
      on delete restrict;

