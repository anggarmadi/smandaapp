import 'package:get/get.dart';

import '../modules/add_user/bindings/add_user_binding.dart';
import '../modules/add_user/views/add_user_view.dart';
import '../modules/daftar_siswa/bindings/daftar_siswa_binding.dart';
import '../modules/daftar_siswa/views/daftar_siswa_view.dart';
import '../modules/detail_absen/bindings/detail_absen_binding.dart';
import '../modules/detail_absen/views/detail_absen_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/ganti_passoword/bindings/ganti_passoword_binding.dart';
import '../modules/ganti_passoword/views/ganti_passoword_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/izin_keluar/bindings/izin_keluar_binding.dart';
import '../modules/izin_keluar/views/izin_keluar_view.dart';
import '../modules/izin_pulang/bindings/izin_pulang_binding.dart';
import '../modules/izin_pulang/views/izin_pulang_view.dart';
import '../modules/izin_sementara/bindings/izin_sementara_binding.dart';
import '../modules/izin_sementara/views/izin_sementara_view.dart';
import '../modules/keterlambatan/bindings/keterlambatan_binding.dart';
import '../modules/keterlambatan/views/keterlambatan_view.dart';
import '../modules/list_absen/bindings/list_absen_binding.dart';
import '../modules/list_absen/views/list_absen_view.dart';
import '../modules/list_izin_keluar/bindings/list_izin_keluar_binding.dart';
import '../modules/list_izin_keluar/views/list_izin_keluar_view.dart';
import '../modules/list_keterlambatan/bindings/list_keterlambatan_binding.dart';
import '../modules/list_keterlambatan/views/list_keterlambatan_view.dart';
import '../modules/list_user/bindings/list_user_binding.dart';
import '../modules/list_user/views/list_user_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/rekap/bindings/rekap_binding.dart';
import '../modules/rekap/views/rekap_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DAFTAR_SISWA,
      page: () => DaftarSiswaView(),
      binding: DaftarSiswaBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REKAP,
      page: () => RekapView(),
      binding: RekapBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => UsersView(),
      binding: UsersBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_USER,
      page: () => AddUserView(),
      binding: AddUserBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_PASSOWORD,
      page: () => const GantiPassowordView(),
      binding: GantiPassowordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.KETERLAMBATAN,
      page: () => KeterlambatanView(),
      binding: KeterlambatanBinding(),
    ),
    GetPage(
      name: _Paths.LIST_KETERLAMBATAN,
      page: () => ListKeterlambatanView(),
      binding: ListKeterlambatanBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LIST_ABSEN,
      page: () => ListAbsenView(),
      binding: ListAbsenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DETAIL_ABSEN,
      page: () => DetailAbsenView(),
      binding: DetailAbsenBinding(),
    ),
    GetPage(
      name: _Paths.LIST_USER,
      page: () => ListUserView(),
      binding: ListUserBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_KELUAR,
      page: () => IzinKeluarView(),
      binding: IzinKeluarBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_SEMENTARA,
      page: () => IzinSementaraView(),
      binding: IzinSementaraBinding(),
    ),
    GetPage(
      name: _Paths.LIST_IZIN_KELUAR,
      page: () => ListIzinKeluarView(),
      binding: ListIzinKeluarBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_PULANG,
      page: () => IzinPulangView(),
      binding: IzinPulangBinding(),
    ),
  ];
}
