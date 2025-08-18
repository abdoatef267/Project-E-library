class AppStrings {
  // أزرار عامة
  static const String btnAddStory = 'إضافة قصة جديدة';
  static const String btnSave = 'حفظ';
  static const String btnCancel = 'إلغاء';
  static const String btnDelete = 'حذف';
  static const String btnEdit = 'تعديل';
  static const String btnShowPdf = 'عرض ملف PDF';
  static const String btnAddPhotos = 'إضافة صور';
  static const String btnLogin = 'تسجيل الدخول';
  static const String btnRegister = 'تسجيل حساب جديد';
  static const String btnToggleDarkMode = 'تبديل الوضع الداكن';
  static const String btnLogout = 'تسجيل الخروج';

  // العناوين
  static const String titleAddStory = 'إضافة قصة جديدة';
  static const String titleEditStory = 'تعديل القصة';
  static const String titleConfirmDelete = 'تأكيد الحذف';
  static const String titleHomePage = 'الصفحة الرئيسية';
  static const String titleFavorites = 'المفضلة';
  static const String titleSettings = 'الإعدادات';
  static const String titleEditProfile = 'تعديل الملف الشخصي';
  static const String titleLogin = 'تسجيل الدخول';
  static const String titleRegister = 'تسجيل حساب';
  static const String titleStoryDetails = 'تفاصيل القصة';
  static const String titleStoryPdfViewer = 'عرض القصة';

  // رسائل تأكيد وخطأ
  static const String msgConfirmDelete = 'هل أنت متأكد من حذف هذه القصة؟ لا يمكن التراجع عن هذا الإجراء.';
  static const String msgNoPdfAvailable = 'لا يوجد ملف PDF متاح لهذه القصة';
  static const String msgInvalidPdfUrl = 'رابط ملف PDF غير صالح';
  static const String msgFailedToOpenPdf = 'تعذر فتح ملف PDF';
  static const String msgStoryAddedSuccess = 'تم إضافة القصة بنجاح';
  static const String msgStoryDeletedSuccess = 'تم حذف القصة بنجاح';
  static const String msgStorySaveSuccess = 'تم حفظ التعديلات بنجاح';
  static const String msgErrorOccurred = 'حدث خطأ أثناء العملية';
  static const String msgAddAtLeastOneImage = 'من فضلك أضف صورة واحدة على الأقل';
  static const String msgProfileUpdatedSuccess = 'تم تحديث الملف الشخصي بنجاح';
  static const String msgNoFavoriteStories = 'لا توجد قصص مفضلة حتى الآن';
  static const String msgNoSearchResults = 'لا توجد نتائج';
  static const String msgUserNotLoggedIn = 'المستخدم غير مسجل الدخول';
  static const String msgFailedToLoadUserData = 'فشل تحميل بيانات المستخدم';
  static const String msgFailedToLoadStories = 'حدث خطأ أثناء تحميل القصص';
  static const String msgInvalidEmailFormat = 'يرجى إدخال بريد إلكتروني صحيح';
  static const String msgPasswordTooShort = 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر';
  static const String msgEnterName = 'يرجى إدخال الاسم';

  // أخطاء في الفورم
  static const String errEnterTitle = 'من فضلك أدخل اسم القصة';
  static const String errEnterAuthor = 'من فضلك أدخل اسم المؤلف';
  static const String errEnterPageCount = 'من فضلك أدخل عدد الصفحات';
  static const String errInvalidPageCount = 'من فضلك أدخل رقم صحيح';
  static const String errEnterShortDescription = 'من فضلك أدخل وصفًا قصيرًا';
  static const String errEnterFullDescription = 'من فضلك أدخل الوصف الكامل';
  static const String errEnterValidUrl = 'يرجى إدخال رابط صالح يبدأ بـ http أو https';
  static const String errEnterEmail = 'يرجى إدخال البريد الإلكتروني';
  static const String errEnterPassword = 'الرجاء إدخال كلمة المرور';

  // نصوص عامة أخرى
  static const String labelTitle = 'عنوان القصة';
  static const String labelAuthor = 'المؤلف';
  static const String labelPageCount = 'عدد الصفحات';
  static const String labelShortDescription = 'وصف قصير';
  static const String labelFullDescription = 'الوصف الكامل';
  static const String labelPdfUrl = 'رابط ملف القصة (PDF أو غيره)';
  static const String labelName = 'الاسم';
  static const String labelEmail = 'البريد الإلكتروني';
  static const String labelPassword = 'كلمة المرور';
  static const String labelPasswordOptional = 'كلمة المرور (اتركه فارغًا إذا لم ترغب في التغيير)';
  static const String labelSearchStory = 'ابحث عن قصة...';
  static const String labelPages = 'صفحات';

  // نصوص رسائل Toast
  static const String toastEmptyEmail = 'الرجاء إدخال البريد الإلكتروني';
  static const String toastEmptyPassword = 'الرجاء إدخال كلمة المرور';
  static const String toastEmptyConfirmPassword = 'الرجاء تأكيد كلمة المرور';
  static const String toastPasswordMismatch = 'كلمة المرور وتأكيدها غير متطابقين';
  static const String toastRegistrationSuccess = 'تم تسجيل الحساب بنجاح';
  static const String toastLoginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String toastErrorOccurred = 'حدث خطأ أثناء العملية';
  static const String toastAddAtLeastOneImage = 'من فضلك أضف صورة واحدة على الأقل';
  static const String toastStoryAddedSuccess = 'تم إضافة القصة بنجاح';
  static const String toastProfileUpdatedSuccess = 'تم تحديث الملف الشخصي بنجاح';
  static const String toastStoryDeletedSuccess = 'تم حذف القصة بنجاح';
  static const String toastStorySaveSuccess = 'تم حفظ التعديلات بنجاح';
  static const String toastNoPdfAvailable = 'لا يوجد ملف PDF متاح لهذه القصة';
  static const String toastInvalidPdfUrl = 'رابط ملف PDF غير صالح';
  static const String toastFailedToOpenPdf = 'تعذر فتح ملف PDF';
  static const String toastFailedToLoadStories = 'حدث خطأ أثناء تحميل القصص';
  static const String toastUserNotLoggedIn = 'المستخدم غير مسجل الدخول';
  static const String toastFailedToLoadUserData = 'فشل تحميل بيانات المستخدم';
  static const String toastStoryRemovedFromFavorites = 'تم حذف القصة من المفضلة';
  static const String toastStoryAddedToFavorites = 'تمت إضافة القصة إلى المفضلة';
  static const String toastFailedToUpdateFavorites = 'فشل تحديث المفضلة';
}