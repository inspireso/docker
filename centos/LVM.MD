# LVM操作

## 常用命令

- fdisk -l
- df -hl
- vgdisplay
- vgextend cl /dev/sdb
- lvdisplay
- lvextend -L xxxG /dev/cl/xxxx



## LV扩容

```sh
# 创建新的PV
$ pvcreate  /dev/sdb
  Physical volume "/dev/sdb" successfully created.
  
$ vgdisplay
  --- Volume group ---
  VG Name               cl
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               49.00 GiB
  PE Size               4.00 MiB
  Total PE              12543
  Alloc PE / Size       12543 / 49.00 GiB
  Free  PE / Size       0 / 0
  VG UUID               MfTw4g-95QB-ZOVB-CS8T-UVWQ-TIWr-2JhlBd

# 扩容VG,直接把pv(/dev/sdb)添加到vg
$ vgextend cl /dev/sdb
  Volume group "cl" successfully extended

# 显示VG信息
$ vgdisplay
  --- Volume group ---
  VG Name               cl
  System ID
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  3
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               448.99 GiB
  PE Size               4.00 MiB
  Total PE              114942
  Alloc PE / Size       12543 / 49.00 GiB
  Free  PE / Size       102399 / 400.00 GiB
  VG UUID               MfTw4g-95QB-ZOVB-CS8T-UVWQ-TIWr-2JhlBd

# 显示LV信息
$ lvdisplay
  --- Logical volume ---
  LV Path                /dev/cl/root
  LV Name                root
  VG Name                cl
  LV UUID                WDRRzR-dcH1-WKPG-2zY6-JzvG-enw9-xZfFkm
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2017-02-16 16:58:55 +0800
  LV Status              available
  # open                 1
  LV Size                49.00 GiB
  Current LE             12543
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0

# 扩容200G
$ lvextend -L +200G /dev/cl/root
  Size of logical volume cl/root changed from 49.00 GiB (12543 extents) to 249.00 GiB (63743 extents).
  Logical volume cl/root successfully resized.

# 扩容XFS分区
$ xfs_growfs /dev/cl/root
meta-data=/dev/mapper/cl-root    isize=512    agcount=4, agsize=3211008 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=12844032, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=6271, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 12844032 to 65272832

```