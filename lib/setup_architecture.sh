#!/bin/bash

# MVVM + Riverpod mimarisi için Flutter proje yapısı oluşturma
# Oluşturan: DenizDogan21
# Tarih: 2025-07-22

# Renkli çıktı için
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Gym Coaches MVVM+Riverpod mimarisi oluşturuluyor...${NC}"

# Core katmanı
mkdir -p lib/core/constants
mkdir -p lib/core/errors
mkdir -p lib/core/extensions
mkdir -p lib/core/services
mkdir -p lib/core/utils

# Data katmanı
mkdir -p lib/data/datasources/remote
mkdir -p lib/data/datasources/local
mkdir -p lib/data/models
mkdir -p lib/data/repositories

# Domain katmanı
mkdir -p lib/domain/entities
mkdir -p lib/domain/repositories

# Presentation katmanı
mkdir -p lib/presentation/common/widgets
mkdir -p lib/presentation/common/theme

# Özellik modülleri
# Auth (Kimlik doğrulama)
mkdir -p lib/presentation/features/auth/views
mkdir -p lib/presentation/features/auth/widgets
mkdir -p lib/presentation/features/auth/viewmodels

# Students (Öğrenciler)
mkdir -p lib/presentation/features/students/views
mkdir -p lib/presentation/features/students/widgets
mkdir -p lib/presentation/features/students/viewmodels

# Workout Programs (Antrenman programları)
mkdir -p lib/presentation/features/workout_programs/views
mkdir -p lib/presentation/features/workout_programs/widgets
mkdir -p lib/presentation/features/workout_programs/viewmodels

# Calendar (Takvim)
mkdir -p lib/presentation/features/calendar/views
mkdir -p lib/presentation/features/calendar/widgets
mkdir -p lib/presentation/features/calendar/viewmodels

# Payments (Ödemeler)
mkdir -p lib/presentation/features/payments/views
mkdir -p lib/presentation/features/payments/widgets
mkdir -p lib/presentation/features/payments/viewmodels

# Providers
mkdir -p lib/presentation/providers

# Routes dosyası
touch lib/routes.dart

echo -e "${GREEN}MVVM+Riverpod klasör yapısı başarıyla oluşturuldu!${NC}"
echo -e "${BLUE}Ana özellikler:${NC}"
echo "- Auth (Kimlik doğrulama)"
echo "- Students (Öğrenciler)"
echo "- Workout Programs (Antrenman programları)" 
echo "- Calendar (Takvim)"
echo "- Payments (Ödeme takibi)"

echo -e "\n${BLUE}Klasör yapısını IDE'de yenileyin ve geliştirmeye başlayabilirsiniz.${NC}"