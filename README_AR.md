<p align="center">
  <img src="assets/logo.png" width="220" alt="GREEN ARMOR CYBER SECURITY">
</p>

<h1 align="center">GREEN ARMOR CYBER RANGE</h1>
<p align="center"><strong>مختبر Pivoting, Tunneling & Port Forwarding</strong></p>

<p align="center">
  <a href="README.md">English</a> ·
  <a href="docs/STUDENT-GUIDE.md">دليل المهمة</a> ·
  <a href="docs/TROUBLESHOOTING.md">حل المشاكل</a>
</p>

## فكرة المشروع

بيئة تدريب محلية معزولة تعمل باستخدام Docker، ومصممة للتدريب العملي على:

- اكتشاف الشبكة وفهم المسارات
- تحديد الجهاز المناسب ليكون Pivot Host
- SSH Local Port Forwarding
- SSH Dynamic Port Forwarding / SOCKS
- استخدام Proxychains عبر SOCKS Tunnel
- الوصول إلى خدمات داخلية غير متاحة مباشرة من جهاز المهاجم
- توثيق مسار الوصول والأدلة

**Created & Developed by Jehad Ghaben**  
**Founder & CEO — GREEN ARMOR CYBER SECURITY**

## بنية المختبر

```text
Corporate Network 172.16.10.0/24

 ga-attacker 172.16.10.10
          |
          | SSH
          v
 ga-pivot 172.16.10.20
          10.10.20.20
          |
          +---------------- Internal Network 10.10.20.0/24
                              |
                              +-- ga-internal-web 10.10.20.30:80
                              +-- ga-internal-ssh 10.10.20.40:22
```

جهاز `ga-attacker` موجود فقط على شبكة Corporate، بينما `ga-pivot` متصل بالشبكتين، والخدمات الداخلية موجودة فقط داخل شبكة Internal.

## المتطلبات

- Docker Engine أو Docker Desktop
- Docker Compose v2
- Linux أو macOS أو Windows مع WSL2/Docker Desktop
- يفضل توفر 2 GB RAM و2 GB مساحة فارغة على الأقل

## التشغيل

بعد تنزيل المشروع:

```bash
cd green-armor-cyber-range
chmod +x *.sh tests/*.sh
./start.sh
```

ثم ادخل إلى جهاز المهاجم:

```bash
./shell.sh
```

ومن داخله:

```bash
mission
myip
routes
```

## بيانات التدريب

Pivot Host:

```text
Username: pivot
Password: PivotLab2026!
```

Internal SSH:

```text
Username: internal
Password: InternalLab2026!
```

## مسار التدريب

```text
Discovery
  ↓
Pivot Identification
  ↓
Tunnel
  ↓
Internal Access
  ↓
Validation
  ↓
Documentation
```

التفاصيل المطلوبة من الطالب موجودة في [`docs/STUDENT-GUIDE.md`](docs/STUDENT-GUIDE.md).

## التحقق الكامل من المختبر

بعد تشغيل البيئة نفذ:

```bash
./tests/self-test.sh
```

النتيجة الصحيحة النهائية:

```text
Self-test result: 12 passed, 0 failed.
```

الاختبار يتحقق من تشغيل الحاويات، عناوين IP، عزل الشبكة الداخلية، الوصول إلى Pivot، ونجاح Local Forwarding وDynamic SOCKS والوصول إلى الخدمتين الداخليتين.

## أوامر الإدارة

```bash
./start.sh
./status.sh
./shell.sh
./tests/self-test.sh
./reset.sh
./stop.sh
```

أو:

```bash
make start
make status
make shell
make test
make reset
make stop
```

## الاستخدام الآمن

هذا المشروع مخصص للتدريب المحلي المعزول. لا تستخدم الأساليب الموجودة فيه على أنظمة حقيقية إلا ضمن نطاق مصرح به بشكل واضح.
