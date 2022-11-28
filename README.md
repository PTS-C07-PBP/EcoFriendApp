# 🍀 EcoFriend 🍀

**Tautan APK EcoFriend** 

xxxxxxxxxxxxxxxx

***

**Anggota kelompok C07**
1. Airel Camilo Khairan (2106652581)
2. Farel Rishad Akasya (2106631646)
3. Kaylee Rudaina Danisha (2106654971)
4. Rahma Adinda Putri (2106750774)
5. Syifa Mumtaz Wazdy (2106701066)
6. Valencius Apriady Primayudha (2106750830)

***

**Deskripsi aplikasi**

Diketahui pada tahun 2022, isu perubahan iklim menjadi krusial karena para peneliti memperkirakan bahwa perubahan iklim dapat membahayakan alam dalam beberapa tahun ke depan. Kenaikan suhu bumi yang disebabkan oleh tingginya jejak karbon juga menyebabkan pencairan es berlebih di kutub sehingga permukaan laut naik secara signifikan dan ekosistem di kutub pun turut terganggu. Jejak karbon adalah jumlah emisi atau gas rumah kaca (termasuk karbon dioksida) yang dihasilkan dari berbagai aktivitas manusia dalam kurun waktu tertentu. Seiring dengan membludaknya populasi dan globalisasi, jejak karbon secara otomatis meningkat dan mempengaruhi iklim dunia secara negatif. Salah satu alasan jejak karbon dapat meningkat dengan drastis adalah mayoritas orang tidak mengetahui dan mencermati seberapa merusak kegiatan sehari-hari yang dilakukan. 

Sebagai solusi dari permasalahan tersebut, kami merencanakan pembuatan aplikasi **EcoFriend** untuk memudahkan para penggunanya dalam menghitung jejak karbon sehingga mengurangi dampak negatif perubahan iklim. Aplikasi ini akan membantu penggunanya menghitung jejak karbon kendaraan pribadi dan melacak penggunaan transportasi umum. Dengan begitu, pengguna diharapkan akan semakin sadar seberapa besar pengaruh penggunaan transportasi umum terhadap pengurangan jejak karbon. Selain itu, pada aplikasi ini disediakan informasi tentang isu perubahan iklim dari berbagai penjuru dunia. Hal ini diharapkan dapat meningkatkan kesadaran dan kepedulian pengguna terhadap isu perubahan iklim ini.

Aktor pengguna aplikasi:
1. User Login
- Dapat mengakses form carbon footprint tracker 
- Dapat melihat data diri, status level, dan hal-hal lain berkaitan dengan akun milik user
- Dapat mengakses fitur calories burned
- Dapat mengisi form app review dan melihat review
- Dapat melihat dan ikut serta dalam fitur Ranking

2. User Belum Login
- Dapat mengakses News about Current Environmental Issues
- Dapat melihat review yang sudah ada di halaman review

***

**Daftar modul yang akan diimplementasikan**
1. News about Current Environmental Issues 

    *Penjelasan singkat:* Bagian yang menampilkan berbagai informasi terkini yang sedang terjadi berkaitan dengan kondisi atau permasalahan yang sedang terjadi lingkungan kita. Halaman ini akan menjadi halaman utama yang menampilkan berbagai informasi dari lingkungan sekitar kita untuk meningkatkan daya tarik dan menambah wawasan user yang mengakses website.
    
    *Dikerjakan oleh:* Airel
    
    *Alur pengintegrasian web service:* Modul ini akan menampilkan artikel tentang isu lingkungan yang didapat dari halaman web UN News. Artikel tersebut ditampilkan dalam sebuah kartu yang berisi gambar, judul, tanggal pembuatan, wilayah yang berkaitan, dan deskripsi singkat. Kemudian ketika pengguna menekan kartu, pengguna akan dialihkan ke halaman web artikel tersebut. Selain itu, di modul ini juga terdapat halaman untuk membuat artikel. Di halaman tersebut terdapat input berupa judul, dropdown wilayah, dan deskripsi dari artikel tersebut. Cara implementasi dari fitur-fitur tersebut adalah dengan memanfaatkan API (Application Programming Interface) dalam kode back-end Django yang sudah ada berupa fungsi yang mengembalikan data artikel ketika melakukan GET dan menambahkan data artikel ketika melakukan POST.

2. Carbon Footprint Tracker (Transportasi)  

    *Penjelasan singkat:* Tempat yang akan digunakan untuk menginput jarak yang ditempuh dengan berbagai sarana, seperti mengendarai keadaan pribadi. Halaman ini kemudian akan menampilkan history hasil setiap kali user melakukan input yang hasil data inputnya akan digunakan oleh modul lain yang berkaitan.
    
    *Dikerjakan oleh:* Rahma

    *Alur pengintegrasian web service:* Modul ini akan menampilkan *history* perhitungan jejak karbon pengguna sesuai yang diinput. Tampilan data akan disajikan dengan *cards* yang berisi detail serta keterangan waktu. Terdapat juga kolom untuk menambahkan *history* pengguna. Implementasinya akan menggunakan API *backend* Django dari aplikasi website yang sudah dibuat sebelumnya. Pengaksesan data JSON dilakukan melalui request HTML dengan method GET dan POST yang akan memanfaatkan library `http` dan  fungsi asinkronus untuk mengambil data terkait.

3. Ranking 

    *Penjelasan singkat:* Menampilkan poin-poin yang sudah didapatkan oleh user melalui perhitungan jejak karbon setiap kali user memberikan input pada carbon footprint tracker. Tujuannya adalah untuk memberikan reward dan juga motivasi bagi setiap user agar mereka mau untuk menjadi yang terbaik dengan mendapatkan poin sebanyak-banyaknya. Semakin sedikit jejak karbon yang mereka tinggalkan, maka semakin tinggi poin mereka karena sudah berpartisipasi mengurangi jejak karbon.
    
    *Dikerjakan oleh:* Farel

4. Calories burned (Person health condition) 

    *Penjelasan singkat:* Menampilkan jumlah kalori terbakar berdasarkan jarak yang diinput pada fitur tracker jika user berjalan kaki. Fitur ini juga menampilkan dan menginput motivasi yang dapat berasal dari user lainnya. Fitur ini bertujuan untuk memberikan motivasi bagi para user yang sudah ikut berpartisipasi mengurangi jejak karbon dengan berjalan kaki.
    
    *Dikerjakan oleh:* Valencius
    
    *Alur pengintegrasian web service:* Pada bagian modul ini akan ditampilkan sebuah representasi data yang menunjukkan jumlah kalori yang terbakar. Jumlah kalori terbakar ini dihitung dengan mengambil data yang didapatkan dari modul Carbon Footprint Tracker. Data yang diambil hanya data jarak yang ditempuh dengan berjalan kaki. Tampilan data akan disajikan dengan sebuah grafik batang disertai dengan tabel detail kalori yang terbakar dengan aktivitas berjalan kaki yang sudah dilakukan. Di bagian bawah dari tabel dan grafik yang sudah tersaji akan diberikan kolom untuk menambahkan motivasi yang kemudian dapat dilihat oleh seluruh pengguna lainnya. Untuk mengimplementasikan fitur-fitur yang sudah disebutkan di atas, maka kita akan menggunakan API (Application Programming Interface) sederhana di kode back-end Djando dari aplikasi website yang sudah kita buat sebelumnya. Kemudian kita dapat mengakses data JSON melalui request HTML dengan method GET dan POST menuju route url yang tepat. Untuk melakukannya maka akan digunakan library http yang sudah ada di dalam Dart dan membuat fungsi asinkronus untuk melakukan request HTML untuk mendapatkan data-data yang dibutuhkan

5. User 

    *Penjelasan singkat:* Bagian yang untuk menginput data untuk mendaftar sebagai pengguna dan kemudian akan menampilkan data diri yang tadi sudah dimasukkan. User juga dapat membuat notes singkat yang berfungsi untuk *track* harinya.
    
    *Dikerjakan oleh:* Kaylee
    
    *Alur pengintergrasian web service*: Modul User akan menampilkan data diri pengguna seperti username, nama dan email dari user yang didapatkan saat melakukan registrasi akun. Selain itu, akan ditambahkan agar dapat menampilkan poinnya saat ini dan user juga bisa membuat notes di halaman profilenya yang akan ditampilkan berbentuk *card*. Implementasi dari fitur tersebut akan memanfaatkan API dalam *backend* Django yang sudah ada dari aplikasi yang sebelumnya sudah dibuat. Data yang telah ada dapat diambil menggunakan method POST dan GET dan akan dimasukkan kembali menggunakan library `http` hingga akhirnya dapat ditampilkan dalam aplikasi yang dibuat.

6. App Review dan nambahin review kita 

    *Penjelasan singkat:* Menampilkan review app dari para pengguna. Pada bagian ini, pengguna juga dapat memberikan review langsung lewat app.
    
    *Dikerjakan oleh:* Syifa
    
    *Alur pengintergrasian web service*: Modul Review akan menampilkan daftar review yang diberikan oleh pengguna terhadap aplikasi EcoFriend. Daftar review terebut ditampilkan dalam bentuk kartu-kartu. Setiap kartu akan menampilkan username, tanggal, serta judul dan review yang dimasukkan secara asinkronus. Untuk mengimplementasikan fitur tersebut, maka akan digunakan API (Application Programming Interface) sederhana di kode back-end Djando bagian Review. API akan mengembalikan data dalam bentuk JSON melalui request HMTL metode GET dan POST ke url yang tepat. Akan ada sebuah fungsi asinkronis yang diimplementasikan untuk dapat melakukan request tersebut untuk mengambil data yang dibutuhkan.
    
