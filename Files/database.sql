-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 13, 2024 at 06:00 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `contact`, `address`, `email_verified_at`, `image`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Mr Admin', 'admin@example.com', 'admin', '+60  036253-1370', '477 Jalan Kelapa Hijau Segambut Bahagia', NULL, '6667e37a558631718084474.png', '$2y$12$ZGhZSJpa/CtjT6omKsFKr.HrsKBCE7EhfQx8JrPRrO6OrKvBdYqRS', NULL, NULL, '2024-06-14 00:40:24');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `click_url` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

CREATE TABLE `campaigns` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gallery` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goal_amount` decimal(28,8) UNSIGNED NOT NULL,
  `preferred_amounts` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `raised_amount` decimal(28,8) UNSIGNED NOT NULL DEFAULT '0.00000000',
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '2' COMMENT '0 -> campaign rejected, 1 -> campaign approved, 2 -> campaign pending',
  `featured` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 -> campaign not featured, 1 -> campaign is featured',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0 -> category is inactive, 1 -> category is active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `campaign_id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '2' COMMENT '0 -> comment rejected by admin, 1 -> comment approved by admin, 2 -> comment is pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint UNSIGNED NOT NULL,
  `campaign_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'this user is actually the donor',
  `donor_type` tinyint UNSIGNED NOT NULL COMMENT '1 -> known donor, 0 -> anonymous donor',
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receiver_id` int UNSIGNED NOT NULL,
  `method_code` int UNSIGNED NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `method_currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `final_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `details` text COLLATE utf8mb4_unicode_ci,
  `btc_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_wallet` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_try` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT '0',
  `admin_feedback` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_data` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `form_id` int UNSIGNED NOT NULL DEFAULT '0',
  `code` int UNSIGNED DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NULL',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=>Active, 2=>Inactive',
  `gateway_parameters` text COLLATE utf8mb4_unicode_ci,
  `supported_currencies` text COLLATE utf8mb4_unicode_ci,
  `crypto` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: fiat currency, 1: crypto currency',
  `extra` text COLLATE utf8mb4_unicode_ci,
  `guideline` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `guideline`, `created_at`, `updated_at`) VALUES
(1, 0, 507, 'BTCPay', 'BTCPay', 1, '{\"store_id\":{\"title\":\"Store Id\",\"global\":true,\"value\":\"-----------------\"},\"api_key\":{\"title\":\"Api Key\",\"global\":true,\"value\":\"-----------------\"},\"server_name\":{\"title\":\"Server Name\",\"global\":true,\"value\":\"-----------------\"},\"secret_code\":{\"title\":\"Secret Code\",\"global\":true,\"value\":\"-----------------\"}}', '{\"BTC\":\"Bitcoin\",\"LTC\":\"Litecoin\"}', 1, '{\"webhook\":{\"title\": \"IPN URL\",\"value\":\"ipn.BTCPay\"}}', NULL, NULL, '2024-03-26 07:50:32'),
(2, 0, 102, 'Perfect Money', 'PerfectMoney', 1, '{\"passphrase\":{\"title\":\"Alternate Passpharse\",\"global\":true,\"value\":\"-----------------\"},\"wallet_id\":{\"title\":\"PM Wallet\",\"global\":false,\"value\":\"\"}}', '{\"USD\":\"$\",\"EUR\":\"\\u20ac\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2024-03-26 07:52:08'),
(3, 0, 106, 'Payeer', 'Payeer', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"-----------------\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"RUB\":\"RUB\"}', 0, '{\"status\":{\"title\": \"Status URL\",\"value\":\"ipn.Payeer\"}}', NULL, '2019-09-14 13:14:22', '2024-03-26 07:51:18'),
(4, 0, 107, 'PayStack', 'Paystack', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"-----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"NGN\":\"NGN\"}', 0, '{\"callback\":{\"title\": \"Callback URL\",\"value\":\"ipn.Paystack\"},\"webhook\":{\"title\": \"Webhook URL\",\"value\":\"ipn.Paystack\"}}\r\n', NULL, '2019-09-14 13:14:22', '2024-03-26 07:51:50'),
(6, 0, 109, 'Flutterwave', 'Flutterwave', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"---------------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"---------------------\"},\"encryption_key\":{\"title\":\"Encryption Key\",\"global\":true,\"value\":\"---------------------\"}}', '{\"BIF\":\"BIF\",\"CAD\":\"CAD\",\"CDF\":\"CDF\",\"CVE\":\"CVE\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"GHS\":\"GHS\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"KES\":\"KES\",\"LRD\":\"LRD\",\"MWK\":\"MWK\",\"MZN\":\"MZN\",\"NGN\":\"NGN\",\"RWF\":\"RWF\",\"SLL\":\"SLL\",\"STD\":\"STD\",\"TZS\":\"TZS\",\"UGX\":\"UGX\",\"USD\":\"USD\",\"XAF\":\"XAF\",\"XOF\":\"XOF\",\"ZMK\":\"ZMK\",\"ZMW\":\"ZMW\",\"ZWD\":\"ZWD\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2024-02-26 10:06:12'),
(7, 0, 503, 'CoinPayments', 'Coinpayments', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"---------------------\"},\"private_key\":{\"title\":\"Private Key\",\"global\":true,\"value\":\"---------------------\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"---------------------\"}}', '{\"BTC\":\"Bitcoin\",\"BTC.LN\":\"Bitcoin (Lightning Network)\",\"LTC\":\"Litecoin\",\"CPS\":\"CPS Coin\",\"VLX\":\"Velas\",\"APL\":\"Apollo\",\"AYA\":\"Aryacoin\",\"BAD\":\"Badcoin\",\"BCD\":\"Bitcoin Diamond\",\"BCH\":\"Bitcoin Cash\",\"BCN\":\"Bytecoin\",\"BEAM\":\"BEAM\",\"BITB\":\"Bean Cash\",\"BLK\":\"BlackCoin\",\"BSV\":\"Bitcoin SV\",\"BTAD\":\"Bitcoin Adult\",\"BTG\":\"Bitcoin Gold\",\"BTT\":\"BitTorrent\",\"CLOAK\":\"CloakCoin\",\"CLUB\":\"ClubCoin\",\"CRW\":\"Crown\",\"CRYP\":\"CrypticCoin\",\"CRYT\":\"CryTrExCoin\",\"CURE\":\"CureCoin\",\"DASH\":\"DASH\",\"DCR\":\"Decred\",\"DEV\":\"DeviantCoin\",\"DGB\":\"DigiByte\",\"DOGE\":\"Dogecoin\",\"EBST\":\"eBoost\",\"EOS\":\"EOS\",\"ETC\":\"Ether Classic\",\"ETH\":\"Ethereum\",\"ETN\":\"Electroneum\",\"EUNO\":\"EUNO\",\"EXP\":\"EXP\",\"Expanse\":\"Expanse\",\"FLASH\":\"FLASH\",\"GAME\":\"GameCredits\",\"GLC\":\"Goldcoin\",\"GRS\":\"Groestlcoin\",\"KMD\":\"Komodo\",\"LOKI\":\"LOKI\",\"LSK\":\"LSK\",\"MAID\":\"MaidSafeCoin\",\"MUE\":\"MonetaryUnit\",\"NAV\":\"NAV Coin\",\"NEO\":\"NEO\",\"NMC\":\"Namecoin\",\"NVST\":\"NVO Token\",\"NXT\":\"NXT\",\"OMNI\":\"OMNI\",\"PINK\":\"PinkCoin\",\"PIVX\":\"PIVX\",\"POT\":\"PotCoin\",\"PPC\":\"Peercoin\",\"PROC\":\"ProCurrency\",\"PURA\":\"PURA\",\"QTUM\":\"QTUM\",\"RES\":\"Resistance\",\"RVN\":\"Ravencoin\",\"RVR\":\"RevolutionVR\",\"SBD\":\"Steem Dollars\",\"SMART\":\"SmartCash\",\"SOXAX\":\"SOXAX\",\"STEEM\":\"STEEM\",\"STRAT\":\"STRAT\",\"SYS\":\"Syscoin\",\"TPAY\":\"TokenPay\",\"TRIGGERS\":\"Triggers\",\"TRX\":\" TRON\",\"UBQ\":\"Ubiq\",\"UNIT\":\"UniversalCurrency\",\"USDT\":\"Tether USD (Omni Layer)\",\"USDT.BEP20\":\"Tether USD (BSC Chain)\",\"USDT.ERC20\":\"Tether USD (ERC20)\",\"USDT.TRC20\":\"Tether USD (Tron/TRC20)\",\"VTC\":\"Vertcoin\",\"WAVES\":\"Waves\",\"XCP\":\"Counterparty\",\"XEM\":\"NEM\",\"XMR\":\"Monero\",\"XSN\":\"Stakenet\",\"XSR\":\"SucreCoin\",\"XVG\":\"VERGE\",\"XZC\":\"ZCoin\",\"ZEC\":\"ZCash\",\"ZEN\":\"Horizen\"}', 1, NULL, NULL, '2019-09-14 13:14:22', '2023-04-08 03:17:18'),
(8, 0, 506, 'Coinbase Commerce', 'CoinbaseCommerce', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"-----------------\"},\"secret\":{\"title\":\"Webhook Shared Secret\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"JPY\":\"JPY\",\"GBP\":\"GBP\",\"AUD\":\"AUD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CNY\":\"CNY\",\"SEK\":\"SEK\",\"NZD\":\"NZD\",\"MXN\":\"MXN\",\"SGD\":\"SGD\",\"HKD\":\"HKD\",\"NOK\":\"NOK\",\"KRW\":\"KRW\",\"TRY\":\"TRY\",\"RUB\":\"RUB\",\"INR\":\"INR\",\"BRL\":\"BRL\",\"ZAR\":\"ZAR\",\"AED\":\"AED\",\"AFN\":\"AFN\",\"ALL\":\"ALL\",\"AMD\":\"AMD\",\"ANG\":\"ANG\",\"AOA\":\"AOA\",\"ARS\":\"ARS\",\"AWG\":\"AWG\",\"AZN\":\"AZN\",\"BAM\":\"BAM\",\"BBD\":\"BBD\",\"BDT\":\"BDT\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"BIF\":\"BIF\",\"BMD\":\"BMD\",\"BND\":\"BND\",\"BOB\":\"BOB\",\"BSD\":\"BSD\",\"BTN\":\"BTN\",\"BWP\":\"BWP\",\"BYN\":\"BYN\",\"BZD\":\"BZD\",\"CDF\":\"CDF\",\"CLF\":\"CLF\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"CRC\":\"CRC\",\"CUC\":\"CUC\",\"CUP\":\"CUP\",\"CVE\":\"CVE\",\"CZK\":\"CZK\",\"DJF\":\"DJF\",\"DKK\":\"DKK\",\"DOP\":\"DOP\",\"DZD\":\"DZD\",\"EGP\":\"EGP\",\"ERN\":\"ERN\",\"ETB\":\"ETB\",\"FJD\":\"FJD\",\"FKP\":\"FKP\",\"GEL\":\"GEL\",\"GGP\":\"GGP\",\"GHS\":\"GHS\",\"GIP\":\"GIP\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"GTQ\":\"GTQ\",\"GYD\":\"GYD\",\"HNL\":\"HNL\",\"HRK\":\"HRK\",\"HTG\":\"HTG\",\"HUF\":\"HUF\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"IMP\":\"IMP\",\"IQD\":\"IQD\",\"IRR\":\"IRR\",\"ISK\":\"ISK\",\"JEP\":\"JEP\",\"JMD\":\"JMD\",\"JOD\":\"JOD\",\"KES\":\"KES\",\"KGS\":\"KGS\",\"KHR\":\"KHR\",\"KMF\":\"KMF\",\"KPW\":\"KPW\",\"KWD\":\"KWD\",\"KYD\":\"KYD\",\"KZT\":\"KZT\",\"LAK\":\"LAK\",\"LBP\":\"LBP\",\"LKR\":\"LKR\",\"LRD\":\"LRD\",\"LSL\":\"LSL\",\"LYD\":\"LYD\",\"MAD\":\"MAD\",\"MDL\":\"MDL\",\"MGA\":\"MGA\",\"MKD\":\"MKD\",\"MMK\":\"MMK\",\"MNT\":\"MNT\",\"MOP\":\"MOP\",\"MRO\":\"MRO\",\"MUR\":\"MUR\",\"MVR\":\"MVR\",\"MWK\":\"MWK\",\"MYR\":\"MYR\",\"MZN\":\"MZN\",\"NAD\":\"NAD\",\"NGN\":\"NGN\",\"NIO\":\"NIO\",\"NPR\":\"NPR\",\"OMR\":\"OMR\",\"PAB\":\"PAB\",\"PEN\":\"PEN\",\"PGK\":\"PGK\",\"PHP\":\"PHP\",\"PKR\":\"PKR\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"RWF\":\"RWF\",\"SAR\":\"SAR\",\"SBD\":\"SBD\",\"SCR\":\"SCR\",\"SDG\":\"SDG\",\"SHP\":\"SHP\",\"SLL\":\"SLL\",\"SOS\":\"SOS\",\"SRD\":\"SRD\",\"SSP\":\"SSP\",\"STD\":\"STD\",\"SVC\":\"SVC\",\"SYP\":\"SYP\",\"SZL\":\"SZL\",\"THB\":\"THB\",\"TJS\":\"TJS\",\"TMT\":\"TMT\",\"TND\":\"TND\",\"TOP\":\"TOP\",\"TTD\":\"TTD\",\"TWD\":\"TWD\",\"TZS\":\"TZS\",\"UAH\":\"UAH\",\"UGX\":\"UGX\",\"UYU\":\"UYU\",\"UZS\":\"UZS\",\"VEF\":\"VEF\",\"VND\":\"VND\",\"VUV\":\"VUV\",\"WST\":\"WST\",\"XAF\":\"XAF\",\"XAG\":\"XAG\",\"XAU\":\"XAU\",\"XCD\":\"XCD\",\"XDR\":\"XDR\",\"XOF\":\"XOF\",\"XPD\":\"XPD\",\"XPF\":\"XPF\",\"XPT\":\"XPT\",\"YER\":\"YER\",\"ZMW\":\"ZMW\",\"ZWL\":\"ZWL\"}\r\n\r\n', 0, '{\"endpoint\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.CoinbaseCommerce\"}}', NULL, '2019-09-14 13:14:22', '2024-03-26 07:50:44'),
(9, 0, 113, 'Paypal Express', 'PaypalSdk', 1, '{\"clientId\":{\"title\":\"Paypal Client ID\",\"global\":true,\"value\":\"-----------------\"},\"clientSecret\":{\"title\":\"Client Secret\",\"global\":true,\"value\":\"-----------------\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2024-03-26 07:51:28'),
(10, 0, 114, 'Stripe Checkout', 'StripeV3', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"-----------------\"},\"end_point\":{\"title\":\"End Point Secret\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, '{\"webhook\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.StripeV3\"}}', NULL, '2019-09-14 13:14:22', '2024-03-26 07:53:09'),
(11, 0, 119, 'Mercado Pago', 'MercadoPago', 1, '{\"access_token\":{\"title\":\"Access Token\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2024-03-26 07:51:00'),
(12, 0, 120, 'Authorize.net', 'Authorize', 1, '{\"login_id\":{\"title\":\"Login ID\",\"global\":true,\"value\":\"-----------------\"},\"transaction_key\":{\"title\":\"Transaction Key\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2024-03-26 07:50:08'),
(13, 0, 509, 'Now Payments Checkout', 'NowPaymentsCheckout', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"---------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------\"}}', '{\"BTG\":\"BTG\",\"ETH\":\"ETH\",\"XMR\":\"XMR\",\"ZEC\":\"ZEC\",\"XVG\":\"XVG\",\"ADA\":\"ADA\",\"LTC\":\"LTC\",\"BCH\":\"BCH\",\"QTUM\":\"QTUM\",\"DASH\":\"DASH\",\"XLM\":\"XLM\",\"XRP\":\"XRP\",\"XEM\":\"XEM\",\"DGB\":\"DGB\",\"LSK\":\"LSK\",\"DOGE\":\"DOGE\",\"TRX\":\"TRX\",\"KMD\":\"KMD\",\"REP\":\"REP\",\"BAT\":\"BAT\",\"ARK\":\"ARK\",\"WAVES\":\"WAVES\",\"BNB\":\"BNB\",\"XZC\":\"XZC\",\"NANO\":\"NANO\",\"TUSD\":\"TUSD\",\"VET\":\"VET\",\"ZEN\":\"ZEN\",\"GRS\":\"GRS\",\"FUN\":\"FUN\",\"NEO\":\"NEO\",\"GAS\":\"GAS\",\"PAX\":\"PAX\",\"USDC\":\"USDC\",\"ONT\":\"ONT\",\"XTZ\":\"XTZ\",\"LINK\":\"LINK\",\"RVN\":\"RVN\",\"BNBMAINNET\":\"BNBMAINNET\",\"ZIL\":\"ZIL\",\"BCD\":\"BCD\",\"USDT\":\"USDT\",\"USDTERC20\":\"USDTERC20\",\"CRO\":\"CRO\",\"DAI\":\"DAI\",\"HT\":\"HT\",\"WABI\":\"WABI\",\"BUSD\":\"BUSD\",\"ALGO\":\"ALGO\",\"USDTTRC20\":\"USDTTRC20\",\"GT\":\"GT\",\"STPT\":\"STPT\",\"AVA\":\"AVA\",\"SXP\":\"SXP\",\"UNI\":\"UNI\",\"OKB\":\"OKB\",\"BTC\":\"BTC\"}', 1, '', NULL, NULL, '2023-02-14 05:08:04'),
(14, 0, 122, '2Checkout', 'TwoCheckout', 1, '{\"merchant_code\":{\"title\":\"Merchant Code\",\"global\":true,\"value\":\"-----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------\"}}', '{\"AFN\": \"AFN\",\"ALL\": \"ALL\",\"DZD\": \"DZD\",\"ARS\": \"ARS\",\"AUD\": \"AUD\",\"AZN\": \"AZN\",\"BSD\": \"BSD\",\"BDT\": \"BDT\",\"BBD\": \"BBD\",\"BZD\": \"BZD\",\"BMD\": \"BMD\",\"BOB\": \"BOB\",\"BWP\": \"BWP\",\"BRL\": \"BRL\",\"GBP\": \"GBP\",\"BND\": \"BND\",\"BGN\": \"BGN\",\"CAD\": \"CAD\",\"CLP\": \"CLP\",\"CNY\": \"CNY\",\"COP\": \"COP\",\"CRC\": \"CRC\",\"HRK\": \"HRK\",\"CZK\": \"CZK\",\"DKK\": \"DKK\",\"DOP\": \"DOP\",\"XCD\": \"XCD\",\"EGP\": \"EGP\",\"EUR\": \"EUR\",\"FJD\": \"FJD\",\"GTQ\": \"GTQ\",\"HKD\": \"HKD\",\"HNL\": \"HNL\",\"HUF\": \"HUF\",\"INR\": \"INR\",\"IDR\": \"IDR\",\"ILS\": \"ILS\",\"JMD\": \"JMD\",\"JPY\": \"JPY\",\"KZT\": \"KZT\",\"KES\": \"KES\",\"LAK\": \"LAK\",\"MMK\": \"MMK\",\"LBP\": \"LBP\",\"LRD\": \"LRD\",\"MOP\": \"MOP\",\"MYR\": \"MYR\",\"MVR\": \"MVR\",\"MRO\": \"MRO\",\"MUR\": \"MUR\",\"MXN\": \"MXN\",\"MAD\": \"MAD\",\"NPR\": \"NPR\",\"TWD\": \"TWD\",\"NZD\": \"NZD\",\"NIO\": \"NIO\",\"NOK\": \"NOK\",\"PKR\": \"PKR\",\"PGK\": \"PGK\",\"PEN\": \"PEN\",\"PHP\": \"PHP\",\"PLN\": \"PLN\",\"QAR\": \"QAR\",\"RON\": \"RON\",\"RUB\": \"RUB\",\"WST\": \"WST\",\"SAR\": \"SAR\",\"SCR\": \"SCR\",\"SGD\": \"SGD\",\"SBD\": \"SBD\",\"ZAR\": \"ZAR\",\"KRW\": \"KRW\",\"LKR\": \"LKR\",\"SEK\": \"SEK\",\"CHF\": \"CHF\",\"SYP\": \"SYP\",\"THB\": \"THB\",\"TOP\": \"TOP\",\"TTD\": \"TTD\",\"TRY\": \"TRY\",\"UAH\": \"UAH\",\"AED\": \"AED\",\"USD\": \"USD\",\"VUV\": \"VUV\",\"VND\": \"VND\",\"XOF\": \"XOF\",\"YER\": \"YER\"}', 1, '{\"approved_url\":{\"title\": \"Approved URL\",\"value\":\"ipn.TwoCheckout\"}}', NULL, NULL, '2024-03-26 07:53:21'),
(15, 0, 123, 'Checkout', 'Checkout', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"------\"},\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"------\"},\"processing_channel_id\":{\"title\":\"Processing Channel\",\"global\":true,\"value\":\"------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"AUD\":\"AUD\",\"CAN\":\"CAN\",\"CHF\":\"CHF\",\"SGD\":\"SGD\",\"JPY\":\"JPY\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2023-10-05 07:10:52'),
(16, 0, 110, 'RazorPay', 'Razorpay', 1, '{\"key_id\":{\"title\":\"Key Id\",\"global\":true,\"value\":\"-----------------\"},\"key_secret\":{\"title\":\"Key Secret \",\"global\":true,\"value\":\"-----------------\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, NULL, '2024-03-26 07:52:17'),
(17, 1, 1000, 'TurboCashOut', 'turbocashout', 1, '[]', '[]', 0, NULL, '<p>When using a manual payment gateway, follow provided instructions carefully to initiate payment. Provide accurate information and choose a preferred payment method. Keep records of the transaction and allow time for processing. Verify payment and address any issues promptly. Contact customer support if needed. Ensure security and consider providing feedback for improvement.</p>', '2023-09-29 00:40:47', '2024-03-24 15:04:25'),
(18, 2, 1001, 'InstantCash', 'instantcash', 1, '[]', '[]', 0, NULL, '<p>When using a manual payment gateway, follow provided instructions carefully to initiate payment. Provide accurate information and choose a preferred payment method. Keep records of the transaction and allow time for processing. Verify payment and address any issues promptly. Contact customer support if needed. Ensure security and consider providing feedback for improvement.<br></p>', '2023-10-08 08:30:23', '2024-03-24 15:04:12'),
(19, 0, 111, 'Stripe Storefront', 'StripeJs', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"-----------------\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, NULL, '2024-03-26 07:52:36'),
(20, 4, 1002, 'FasterPay', 'fasterpay', 1, '[]', '[]', 0, NULL, '<p>When using a manual payment gateway, follow provided instructions carefully to initiate payment. Provide accurate information and choose a preferred payment method. Keep records of the transaction and allow time for processing. Verify payment and address any issues promptly. Contact customer support if needed. Ensure security and consider providing feedback for improvement.<br></p>', '2023-11-21 07:07:31', '2024-03-24 15:04:01'),
(21, 5, 1003, 'EasyCashOut', 'easycashout', 1, '[]', '[]', 0, NULL, '<p>When using a manual payment gateway, follow provided instructions carefully to initiate payment. Provide accurate information and choose a preferred payment method. Keep records of the transaction and allow time for processing. Verify payment and address any issues promptly. Contact customer support if needed. Ensure security and consider providing feedback for improvement.<br></p>', '2023-11-21 09:12:25', '2024-03-24 15:03:49');

-- --------------------------------------------------------

--
-- Table structure for table `gateway_currencies`
--

CREATE TABLE `gateway_currencies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_code` int UNSIGNED DEFAULT NULL,
  `gateway_alias` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `max_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `percent_charge` decimal(5,2) NOT NULL DEFAULT '0.00',
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `gateway_parameter` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateway_currencies`
--

INSERT INTO `gateway_currencies` (`id`, `name`, `currency`, `symbol`, `method_code`, `gateway_alias`, `min_amount`, `max_amount`, `percent_charge`, `fixed_charge`, `rate`, `gateway_parameter`, `created_at`, `updated_at`) VALUES
(1, 'TurboCashOut', 'USD', '', 1000, 'turbocashout', '1.00000000', '3000.00000000', '5.00', '1.00000000', '0.01000000', NULL, '2023-09-29 00:40:47', '2024-03-24 15:04:25'),
(9, 'InstantCash', 'PKR', '', 1001, 'instantcash', '1.00000000', '1000.00000000', '1.00', '1.00000000', '2.54000000', NULL, '2023-10-08 08:30:23', '2024-03-24 15:04:12'),
(16, 'Now Payments Checkout - AVA', 'AVA', 'AVA', 509, 'NowPaymentsCheckout', '1.00000000', '1000.00000000', '1.00', '1.00000000', '1.89000000', '{\"api_key\":\"---------------\",\"secret_key\":\"-----------\"}', '2023-11-16 11:14:33', '2023-11-16 11:14:33'),
(32, 'FasterPay', 'TRY', '', 1002, 'fasterpay', '1.00000000', '1500.00000000', '1.00', '1.00000000', '0.28000000', NULL, '2023-11-21 07:07:31', '2024-03-24 15:04:01'),
(33, 'EasyCashOut', 'IRR', '', 1003, 'easycashout', '1.00000000', '2500.00000000', '0.00', '0.00000000', '382.53000000', NULL, '2023-11-21 09:12:25', '2024-03-24 15:03:49'),
(38, 'Checkout - USD', 'USD', '$', 123, 'Checkout', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.00910000', '{\"secret_key\":\"------\",\"public_key\":\"------\",\"processing_channel_id\":\"------\"}', '2024-02-26 05:18:51', '2024-02-26 05:18:51'),
(39, 'CoinPayments - BTC', 'BTC', 'BTC', 503, 'Coinpayments', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.00910000', '{\"public_key\":\"---------------------\",\"private_key\":\"---------------------\",\"merchant_id\":\"---------------------\"}', '2024-02-26 07:05:06', '2024-02-26 07:05:06'),
(42, 'Flutterwave - CAD', 'CAD', 'CAD', 109, 'Flutterwave', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"public_key\":\"---------------------\",\"secret_key\":\"---------------------\",\"encryption_key\":\"---------------------\"}', '2024-02-26 10:06:12', '2024-02-26 10:06:12'),
(59, 'Authorize.net - USD', 'USD', '$', 120, 'Authorize', '1.00000000', '1000.00000000', '0.00', '0.00000000', '0.01000000', '{\"login_id\":\"-----------------\",\"transaction_key\":\"-----------------\"}', '2024-03-26 07:50:08', '2024-03-26 07:50:08'),
(60, 'BTCPay - BTC', 'BTC', 'BTC', 507, 'BTCPay', '1.00000000', '1000.00000000', '1.00', '1.00000000', '1.00000000', '{\"store_id\":\"-----------------\",\"api_key\":\"-----------------\",\"server_name\":\"-----------------\",\"secret_code\":\"-----------------\"}', '2024-03-26 07:50:32', '2024-03-26 07:50:32'),
(61, 'Coinbase Commerce - USD', 'USD', '$', 506, 'CoinbaseCommerce', '1.00000000', '1000.00000000', '1.00', '1.00000000', '1.00000000', '{\"api_key\":\"-----------------\",\"secret\":\"-----------------\"}', '2024-03-26 07:50:44', '2024-03-26 07:50:44'),
(62, 'Mercado Pago - USD', 'USD', '$', 119, 'MercadoPago', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"access_token\":\"-----------------\"}', '2024-03-26 07:51:00', '2024-03-26 07:51:00'),
(63, 'Payeer - USD', 'USD', '$', 106, 'Payeer', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"merchant_id\":\"-----------------\",\"secret_key\":\"-----------------\"}', '2024-03-26 07:51:18', '2024-03-26 07:51:18'),
(64, 'Paypal Express - USD', 'USD', '$', 113, 'PaypalSdk', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"clientId\":\"-----------------\",\"clientSecret\":\"-----------------\"}', '2024-03-26 07:51:28', '2024-03-26 07:51:28'),
(65, 'PayStack - NGN', 'NGN', '₦', 107, 'Paystack', '1.00000000', '1000.00000000', '1.00', '1.00000000', '14.23000000', '{\"public_key\":\"-----------------\",\"secret_key\":\"-----------------\"}', '2024-03-26 07:51:50', '2024-03-26 07:51:50'),
(66, 'Perfect Money - USD', 'USD', '$', 102, 'PerfectMoney', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"passphrase\":\"-----------------\",\"wallet_id\":\"-----------------\"}', '2024-03-26 07:52:08', '2024-03-26 07:52:08'),
(67, 'RazorPay - INR', 'INR', '₹', 110, 'Razorpay', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.75000000', '{\"key_id\":\"-----------------\",\"key_secret\":\"-----------------\"}', '2024-03-26 07:52:17', '2024-03-26 07:52:17'),
(68, 'Stripe Storefront - USD', 'USD', '$', 111, 'StripeJs', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"secret_key\":\"-----------------\",\"publishable_key\":\"-----------------\"}', '2024-03-26 07:52:36', '2024-03-26 07:52:36'),
(69, 'Stripe Storefront - AUD', 'AUD', 'A$', 111, 'StripeJs', '1.00000000', '1000.00000000', '5.00', '5.00000000', '0.01000000', '{\"secret_key\":\"-----------------\",\"publishable_key\":\"-----------------\"}', '2024-03-26 07:52:36', '2024-03-26 07:52:36'),
(70, 'Stripe Checkout - USD', 'USD', '$', 114, 'StripeV3', '1.00000000', '1000.00000000', '1.00', '1.00000000', '0.01000000', '{\"secret_key\":\"-----------------\",\"publishable_key\":\"-----------------\",\"end_point\":\"-----------------\"}', '2024-03-26 07:53:09', '2024-03-26 07:53:09'),
(71, '2Checkout - USD', 'USD', '$', 122, 'TwoCheckout', '1.00000000', '1000.00000000', '1.00', '1.00000000', '1.00000000', '{\"merchant_code\":\"-----------------\",\"secret_key\":\"-----------------\"}', '2024-03-26 07:53:21', '2024-03-26 07:53:21');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, NULL, '2024-06-03 20:13:50'),
(7, 'Arabic', 'ar', 1, '2024-06-03 20:37:55', '2024-06-03 20:37:55'),
(9, 'French', 'fr', 1, '2024-06-08 13:17:21', '2024-06-08 13:17:21'),
(10, 'Hindi', 'hn', 1, '2024-06-14 02:41:59', '2024-06-14 02:41:59');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_07_26_091103_create_admins_table', 1),
(6, '2023_07_26_100423_create_admin_password_resets_table', 2),
(7, '2023_08_05_103533_create_settings_table', 3),
(10, '2023_08_15_194830_create_site_data_table', 4),
(11, '2023_08_20_140452_create_languages_table', 5),
(12, '2023_09_25_165355_create_plugins_table', 6),
(13, '2023_09_27_053636_create_gateways_table', 7),
(14, '2023_09_27_170521_create_gateway_currencies_table', 8),
(15, '2023_09_29_062351_create_forms_table', 9),
(16, '2023_10_08_164420_create_notification_templates_table', 10),
(17, '2023_10_08_164602_create_admin_notifications_table', 11),
(18, '2023_10_08_164629_create_notification_logs_table', 12),
(19, '2023_10_09_135811_create_subscribers_table', 13),
(20, '2023_11_16_193930_create_deposits_table', 14),
(21, '2023_11_17_181741_create_transactions_table', 15),
(22, '2023_11_20_150839_create_withdraw_methods_table', 16),
(23, '2023_11_20_150907_create_withdrawals_table', 16),
(24, '2023_12_06_154325_create_contacts_table', 17),
(25, '2024_02_29_170103_create_crypto_currencies_table', 18);

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subj` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci,
  `sms_body` text COLLATE utf8mb4_unicode_ci,
  `shortcodes` text COLLATE utf8mb4_unicode_ci,
  `email_status` tinyint(1) NOT NULL DEFAULT '1',
  `sms_status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `created_at`, `updated_at`) VALUES
(1, 'BAL_ADD', 'Balance - Added', 'Your Account has been Credited', '<div><div style=\"font-family: Montserrat, sans-serif;\">{{amount}} {{site_currency}} has been added to your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">{{post_balance}}&nbsp; {{site_currency}}&nbsp;</span></font><br></div><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin note:&nbsp;<span style=\"color: rgb(33, 37, 41); font-size: 12px; font-weight: 600; white-space: nowrap; text-align: var(--bs-body-text-align);\">{{remark}}</span></div>', '{{amount}} {{site_currency}} credited in your account. Your Current Balance {{post_balance}} {{site_currency}} . Transaction: #{{trx}}. Admin note is \"{{remark}}\"', '{\"trx\":\"Transaction number for the action\",\"amount\":\"Amount inserted by the admin\",\"remark\":\"Remark inserted by the admin\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 0, '2021-11-03 12:00:00', '2022-04-03 02:18:28'),
(2, 'BAL_SUB', 'Balance - Subtracted', 'Your Account has been Debited', '<div style=\"font-family: Montserrat, sans-serif;\">{{amount}} {{site_currency}} has been subtracted from your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">{{post_balance}}&nbsp; {{site_currency}}</span></font><br><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin Note: {{remark}}</div>', '{{amount}} {{site_currency}} debited from your account. Your Current Balance {{post_balance}} {{site_currency}} . Transaction: #{{trx}}. Admin Note is {{remark}}', '{\"trx\":\"Transaction number for the action\",\"amount\":\"Amount inserted by the admin\",\"remark\":\"Remark inserted by the admin\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-03 02:24:11'),
(7, 'PASS_RESET_CODE', 'Password - Reset - Code', 'Password Reset', '<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>', 'Your account recovery code is: {{code}}', '{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 0, '2021-11-03 12:00:00', '2022-03-20 20:47:05'),
(8, 'PASS_RESET_DONE', 'Password - Reset - Confirmation', 'You have reset your password', '<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>', 'Your password has been changed successfully', '{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 1, '2021-11-03 12:00:00', '2022-04-05 03:46:35'),
(9, 'ADMIN_SUPPORT_REPLY', 'Support - Reply', 'Reply Support Ticket', '<div><p><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\">A member from our support team has replied to the following ticket:</span></span></p><p><span style=\"font-weight: bolder;\"><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\"><br></span></span></span></p><p><span style=\"font-weight: bolder;\">[Ticket#{{ticket_id}}] {{ticket_subject}}<br><br>Click here to reply:&nbsp; {{link}}</span></p><p>----------------------------------------------</p><p>Here is the reply :<br></p><p>{{reply}}<br></p></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', 'Your Ticket#{{ticket_id}} :  {{ticket_subject}} has been replied.', '{\"ticket_id\":\"ID of the support ticket\",\"ticket_subject\":\"Subject  of the support ticket\",\"reply\":\"Reply made by the admin\",\"link\":\"URL to view the support ticket\"}', 1, 1, '2021-11-03 12:00:00', '2022-03-20 20:47:51'),
(10, 'EVER_CODE', 'Verification - Email', 'Please verify your email address', '<br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;{{code}}</span></font></div></div>', '---', '{\"code\":\"Email verification code\"}', 1, 0, '2021-11-03 12:00:00', '2022-04-03 02:32:07'),
(11, 'SVER_CODE', 'Verification - SMS', 'Verify Your Mobile Number', '---', 'Your phone verification code is: {{code}}', '{\"code\":\"SMS Verification Code\"}', 0, 1, '2021-11-03 12:00:00', '2022-03-20 19:24:37'),
(12, 'WITHDRAW_APPROVE', 'Withdraw - Approved', 'Withdrawal Approval Notification', '<div style=\"\"><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">We are pleased to inform you that your withdrawal request has been approved by our administration team.<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Here are the details of your approved withdrawal:<span style=\"background-color: var(--bs-card-bg); color: var(--bs-card-color); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;</span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"background-color: var(--bs-card-bg); color: var(--bs-card-color); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\"><br></span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Amount:</span>&nbsp;{{amount}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Charge:</span>&nbsp;{{charge}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Conversion Rate:</span>&nbsp;1 {{site_currency}} = {{rate}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Receivable Amount:</span>&nbsp;{{method_amount}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Withdraw</span><span style=\"font-weight: 700;\">&nbsp;Via:</span>&nbsp;{{method_name}}<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Transaction Number:</span>&nbsp;{{trx}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Post Balance:</span>&nbsp;{{post_balance}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"text-wrap: nowrap;\">{{admin_details}}</span><br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">Your withdrawal request has been processed successfully. If you have any further questions or require assistance, please feel free to contact us.</span><br></p><p style=\"\">Thank you for your patience and cooperation.<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Best<span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;regards,</span></p></div>', 'Good news! Your withdrawal request has been approved.\r\n\r\nDetails of your withdrawal:\r\n\r\nAmount: {{amount}} {{site_currency}}\r\nCharge: {{charge}} {{site_currency}}\r\nConversion Rate: 1 {{site_currency}} = {{rate}} {{method_currency}}\r\nReceivable Amount: {{method_amount}} {{method_currency}}\r\nWithdraw Via: {{method_name}}\r\nTransaction Number: {{trx}}\r\nPost Balance: {{post_balance}} {{site_currency}}\r\n\r\n{{admin_details}}\r\n\r\nFor further assistance, contact us anytime.', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\",\"admin_details\":\"Details provided by the admin\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 06:31:34'),
(13, 'WITHDRAW_REJECT', 'Withdraw - Rejected', 'Withdrawal Rejection Notification', '<div style=\"\"><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">We regret to inform you that your withdrawal request has been rejected by our administration team.<br></p><p style=\"\">Upon careful review, we found that there were certain discrepancies or issues that prevented us from processing your withdrawal at this time. We apologize for any inconvenience this may cause.<br></p><p style=\"\">Here are the details of your withdrawal:<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"background-color: var(--bs-card-bg); color: var(--bs-card-color); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\"><br></span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Amount:</span>&nbsp;{{amount}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Charge:</span>&nbsp;{{charge}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Conversion Rate:</span>&nbsp;1 {{site_currency}} = {{rate}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">You should have received:</span>&nbsp;{{method_amount}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Withdraw</span><span style=\"font-weight: 700;\">&nbsp;Via:</span>&nbsp;{{method_name}}<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Transaction Number:</span>&nbsp;{{trx}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"text-wrap: nowrap;\">{{admin_details}}</span><br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">{{amount}} {{site_currency}} has been refunded to your account, and your current balance is {{post_balance}} {{site_currency}}.</p><p style=\"\">If you have any questions or concerns regarding this decision, or if you believe there has been a misunderstanding, please don\'t hesitate to reach out to us. We are here to assist you and address any concerns you may have.</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Thank you for your understanding.<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Best<span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;regards,</span></p></div><div></div><div></div>', 'We regret to inform you that your withdrawal request of {{amount}} {{site_currency}} via {{method_name}} has been rejected.\r\n\r\nDetails of your withdrawal:\r\n\r\nAmount: {{amount}} {{site_currency}}\r\nCharge: {{charge}} {{site_currency}}\r\nConversion Rate: 1 {{site_currency}} = {{rate}} {{method_currency}}\r\nYou should have received: {{method_amount}} {{method_currency}}\r\nWithdraw Via: {{method_name}}\r\nTransaction Number: {{trx}}\r\n\r\n{{admin_details}}\r\n\r\n{{amount}} {{site_currency}} has been refunded to your account. Your current balance is {{post_balance}} {{site_currency}}.\r\n\r\nIf you have any questions, feel free to reach out.\r\n\r\nBest regards,', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after fter this action\",\"admin_details\":\"Rejection message by the admin\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 07:40:47'),
(14, 'WITHDRAW_REQUEST', 'Withdraw - Requested', 'Withdrawal Request Confirmation', '<div style=\"\"><p style=\"\">We are pleased to inform you that your withdrawal request has been successfully submitted.<br></p><p style=\"\">Here are the details of your withdrawal:<span style=\"background-color: var(--bs-card-bg); color: var(--bs-card-color); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;</span></p><p style=\"\"><span style=\"background-color: var(--bs-card-bg); color: var(--bs-card-color); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\"><br></span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Amount:</span>&nbsp;{{amount}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Charge:</span>&nbsp;{{charge}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Conversion Rate:</span>&nbsp;1 {{site_currency}} = {{rate}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Receivable Amount:</span>&nbsp;{{method_amount}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Withdraw</span><span style=\"font-weight: 700;\">&nbsp;Via:</span>&nbsp;{{method_name}}<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Transaction Number:</span>&nbsp;{{trx}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Post Balance:</span>&nbsp;{{post_balance}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><br></p><p style=\"\">If you have any questions or concerns regarding this transaction, please feel free to contact us. Thank you for choosing <span style=\"text-wrap: nowrap;\">{{site_name}}</span>.</p><p style=\"\">Best<span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;regards,</span></p></div>', 'Your withdrawal request of {{amount}} {{site_currency}} via {{method_name}} has been successfully submitted.\r\n\r\nDetails of your withdrawal:\r\n\r\nAmount: {{amount}} {{site_currency}}\r\nCharge: {{charge}} {{site_currency}}\r\nConversion Rate: 1 {{site_currency}} = {{rate}} {{method_currency}}\r\nReceivable Amount: {{method_amount}} {{method_currency}}\r\nWithdraw Via: {{method_name}}\r\nTransaction Number: {{trx}}\r\nPost Balance: {{post_balance}} {{site_currency}}\r\n\r\nFor any queries, reach out to us.', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 06:03:40'),
(15, 'DEFAULT', 'Default Template', '{{subject}}', '{{message}}', '{{message}}', '{\"subject\":\"Subject\",\"message\":\"Message\"}', 1, 0, '2019-09-14 13:14:22', '2024-02-18 08:37:31'),
(16, 'KYC_APPROVE', 'KYC Approved Successfully', 'KYC has been approved', NULL, NULL, '[]', 1, 1, NULL, NULL),
(17, 'KYC_REJECT', 'KYC Rejected Successfully', 'KYC has been rejected', NULL, NULL, '[]', 1, 1, NULL, NULL),
(18, 'CAMPAIGN_APPROVE', 'Campaign - Approved', 'Your Campaign Has Been Approved!', '<div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"background-color: var(--bs-card-bg); color: var(--bs-card-color); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">I hope this email finds you well.</span><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"\"><font face=\"Montserrat, sans-serif\">I am pleased to inform you that your campaign, \"{{campaign_name}}\" has been successfully reviewed and approved by our team! Congratulations on reaching this milestone.</font><br></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Your creativity and dedication to your cause shine through in the campaign you\'ve created. We believe it will make a significant impact and resonate with our audience.</font></div></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Thank you for your hard work and commitment. We are excited to see your campaign flourish and achieve its goals.<br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Best Regards</font></div>', 'Great news! Your campaign, \"{{campaign_name}}\" has been approved! Get ready to make an impact and reach your goals. Need assistance? Just let us know.', '{\"campaign_name\":\"Name of the campaign\"}', 1, 0, '2021-11-03 12:00:00', '2024-03-07 06:04:23'),
(19, 'CAMPAIGN_REJECT', 'Campaign - Rejected', 'Your Campaign Has Been Rejected!', '<div><div style=\"\"><font face=\"Montserrat, sans-serif\">I hope this email finds you well. I wanted to reach out to you regarding the campaign you recently submitted to our platform.</font><br></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">After careful consideration and review, we regret to inform you that your campaign</font><span style=\"font-family: Montserrat, sans-serif; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">, \"{{campaign_name}}\"</span><span style=\"font-family: Montserrat, sans-serif; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;has not been approved for publication at this time. We understand the effort and creativity you put into your submission, and we truly appreciate your contribution.</span></div><div style=\"\"><span style=\"font-family: Montserrat, sans-serif; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\"><br></span></div><div style=\"\"><span style=\"background-color: var(--bs-card-bg); text-align: var(--bs-body-text-align);\"><font face=\"Montserrat, sans-serif\">Please know that our decision is not a reflection of the quality of your work, but rather a result of our current campaign criteria and objectives. We encourage you to continue exploring and creating, as your ideas are valuable to us.</font><br></span></div><div style=\"\"><span style=\"background-color: var(--bs-card-bg); text-align: var(--bs-body-text-align);\"><font face=\"Montserrat, sans-serif\"><br></font></span></div><div style=\"\"><span style=\"background-color: var(--bs-card-bg); text-align: var(--bs-body-text-align);\"><font face=\"Montserrat, sans-serif\">Thank you for your understanding and continued support. If you have any questions or would like further feedback on your submission, please don\'t hesitate to reach out to us.</font></span></div></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Best Regards</font></div>', 'Unfortunately, your campaign, \"{{campaign_name}}\" submission wasn\'t approved this time. We value your effort but it didn\'t quite fit our criteria. Thank you for understanding. Any queries, just ask.', '{\"campaign_name\":\"Name of the campaign\"}', 1, 0, '2021-11-03 12:00:00', '2024-03-07 06:04:38'),
(20, 'COMMENT_APPROVE', 'Comment - Approved', 'Your Comment Has Been Approved!', '<div><div style=\"\"><font face=\"Montserrat, sans-serif\">We are writing to inform you that your recent comments on&nbsp;</font><span style=\"font-family: Montserrat, sans-serif;\"><b>\"{{campaign_name}}\"</b></span><font face=\"Montserrat, sans-serif\">&nbsp;have been reviewed and approved by our administrative team. We appreciate your contribution and engagement with our community.</font><br></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Your insightful comments add value to the discussions and help foster a positive environment for exchange of ideas. We encourage you to continue participating and sharing your thoughts on topics that interest you.<br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Thank you for your patience during the review process. If you have any further questions or concerns, please don\'t hesitate to reach out to us.</font></div></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Best Regards,</font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">{{site_name}}<br></font></div>', 'Good news! Your comment on \"{{campaign_name}}\" have been approved by our admin team. Keep up the great contributions!', '{\"campaign_name\":\"Name of the campaign\"}', 1, 0, '2021-11-03 12:00:00', '2024-03-07 06:04:56'),
(21, 'COMMENT_REJECT', 'Comment - Rejected', 'Your Comment Has Been Rejected!', '<div><div style=\"\"><font face=\"Montserrat, sans-serif\">We regret to inform you that after careful review, your recent comments on&nbsp;</font><span style=\"font-weight: 700; font-family: Montserrat, sans-serif;\">\"{{campaign_name}}\"</span><font face=\"Montserrat, sans-serif\">&nbsp;have been rejected by our administrative team. We appreciate your effort in contributing to the discussions, however, upon review, we found that your comments did not adhere to our community guidelines.<br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">We encourage you to review our guidelines to ensure future comments align with our standards. Constructive and respectful participation is essential for maintaining a positive environment for all users.<br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">If you have any questions regarding this decision or would like further clarification, please feel free to reach out to us. We\'re here to assist you.<br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Thank you for your understanding.</font></div></div><div style=\"\"><font face=\"Montserrat, sans-serif\"><br></font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Best Regards,</font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">{{site_name}}<br></font></div>', 'Unfortunately, your recent comments on \"{{campaign_name}}\" have been rejected. Please review our guidelines for future submissions. Thanks for your understanding.', '{\"campaign_name\":\"Name of the campaign\"}', 1, 0, '2021-11-03 12:00:00', '2024-03-07 06:05:14'),
(22, 'DONATION_COMPLETE', 'Donation - Automated - Successful', 'Thank You for Your Generous Donation!', '<p>We are thrilled to inform you that your contribution to our campaign has been received and processed successfully. Your support means the world to us and plays a vital role in helping us achieve our goals. Here are the details of your recent donation:<span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;</span></p><p><br></p><p><b>Amount:</b> {{amount}} {{site_currency}}</p><p><b>Charge:</b>&nbsp;{{charge}} {{site_currency}}</p><p><b>Conversion Rate:</b> 1 {{site_currency}} = {{rate}} {{method_currency}}</p><p><b>Donated:</b> {{method_amount}} {{method_currency}}</p><p><span style=\"font-weight: 700; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Donated</span><b>&nbsp;Via:</b>&nbsp;{{method_name}}<br></p><p><b>Transaction Number:</b> {{trx}}</p><p><br></p><p>Your commitment to our cause is deeply appreciated, and we are truly grateful for your generosity. With your support, we can continue our efforts towards \"{{campaign_name}}\" campaign.</p><p>Thank you once again for your generosity and belief in our mission. If you have any questions or need further assistance, please don\'t hesitate to reach out to us.<br></p><p>Warm regards,<br></p>', 'Thank you for your donation of {{amount}} {{site_currency}} to our \"{{campaign_name}}\" campaign via {{method_name}}! Your support is invaluable and will help us make a positive impact.', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"campaign_name\":\"Name of the campaign\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 06:05:34'),
(23, 'DONATION_REQUEST', 'Donation - Manual - Requested', 'Acknowledgement of Donation and Pending Status', '<p>We hope this email finds you well. We are reaching out to express our sincere gratitude for your recent contribution to our campaign. Your support is invaluable to us and brings us one step closer to achieving our goals.<br></p><p>However, we wanted to inform you that your donation is currently in a pending state. Our manual payment gateway requires administrative approval before final processing. Rest assured, our team is working diligently to review and confirm your donation as swiftly as possible.<br></p><p>Here are the details of your recent donation:<br></p><p><br></p><p><span style=\"font-weight: 700;\">Amount:</span>&nbsp;{{amount}} {{site_currency}}</p><p><span style=\"font-weight: 700;\">Charge:</span>&nbsp;{{charge}} {{site_currency}}</p><p><span style=\"font-weight: 700;\">Conversion Rate:</span>&nbsp;1 {{site_currency}} = {{rate}} {{method_currency}}</p><p><span style=\"font-weight: 700;\">Donated:</span>&nbsp;{{method_amount}} {{method_currency}}</p><p><span style=\"font-weight: 700; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Donated</span><span style=\"font-weight: 700;\">&nbsp;Via:</span>&nbsp;{{method_name}}<br></p><p><span style=\"font-weight: 700;\">Transaction Number:</span>&nbsp;{{trx}}</p><p><br></p><p>Your commitment to our cause fills us with gratitude, and we cannot thank you enough for your generosity. Your contribution will directly impact our efforts towards \"{{campaign_name}}\" campaign.</p><p>We understand that this pending status may raise questions or concerns. Please rest assured that we are actively monitoring the situation and will keep you updated on any developments. If you have any inquiries or require further assistance, please do not hesitate to reach out to us.<br></p><p>Once again, thank you for your unwavering support and belief in our mission. Together, we can make a difference.<br></p><p>Warm regards,<br></p>', 'Thank you for your donation of {{amount}} {{site_currency}} to our \"{{campaign_name}}\" campaign via {{method_name}}! Your support is appreciated. Please note that your donation is pending and waiting for admin approval. We\'ll keep you updated.', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"campaign_name\":\"Name of the campaign\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 06:06:29'),
(24, 'DONATION_APPROVE', 'Donation - Manual - Approved', 'Confirmation of Your Generous Donation', '<div style=\"\"><p style=\"\">We hope this email finds you well.<br></p><p style=\"\">We wanted to express our sincerest gratitude for your recent donation to our \"{{campaign_name}}\" campaign. Your generosity is truly appreciated, and your contribution will go a long way in helping us achieve our goals.<span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">&nbsp;</span></p><p style=\"\"><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">Here are the details of your recent donation:</span><span style=\"font-family: var(--bs-body-font-family); color: var(--bs-card-color); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align); background-color: var(--bs-card-bg);\">&nbsp;</span></p><p style=\"\"><span style=\"font-family: var(--bs-body-font-family); color: var(--bs-card-color); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align); background-color: var(--bs-card-bg);\"><br></span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Amount:</span>&nbsp;{{amount}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Charge:</span>&nbsp;{{charge}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Conversion Rate:</span>&nbsp;1 {{site_currency}} = {{rate}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Donated:</span>&nbsp;{{method_amount}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); text-align: var(--bs-body-text-align);\">Donated</span><span style=\"font-weight: 700;\">&nbsp;Via:</span>&nbsp;{{method_name}}<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Transaction Number:</span>&nbsp;{{trx}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Your donation has been successfully processed and approved by our administration. It\'s through the support of kind-hearted individuals like you that we are able to make a difference in our community.</p><p style=\"\">Once again, thank you for your generosity and support. If you have any questions or need further assistance, please don\'t hesitate to contact us.</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Warm regards,</p></div>', 'Thank you for your recent donation to \"{{campaign_name}}\" campaign! Your contribution of {{amount}} {{site_currency}} has been approved and processed successfully.\r\n\r\nTransaction Details:\r\n\r\nAmount: {{amount}} {{site_currency}}\r\nCharge: {{charge}} {{site_currency}}\r\nConversion Rate: 1 {{site_currency}} = {{rate}} {{method_currency}}\r\nDonated: {{method_amount}} {{method_currency}}\r\nDonated Via: {{method_name}}\r\nTransaction Number: {{trx}}\r\n\r\nYour support means the world to us. Together, we\'re making a difference!', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"campaign_name\":\"Name of the campaign\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 06:05:49');
INSERT INTO `notification_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `created_at`, `updated_at`) VALUES
(25, 'DONATION_REJECT', 'Donation - Manual - Rejected', 'Important Update Regarding Your Recent Donation', '<div style=\"\"><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">We hope this email finds you well.<br></p><p style=\"\">We regret to inform you that your recent donation to our \"<span style=\"text-wrap: nowrap; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{{campaign_name}}</span><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">\" campaign has been rejected by our administration. We understand this news may come as a disappointment, and we sincerely apologize for any inconvenience this may cause.&nbsp;</span></p><p style=\"\"><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">Here are the details regarding the rejected donation:</span><span style=\"color: var(--bs-card-color); font-family: var(--bs-body-font-family); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align); background-color: var(--bs-card-bg);\">&nbsp;</span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-family: var(--bs-body-font-family); color: var(--bs-card-color); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align); background-color: var(--bs-card-bg);\"><br></span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Amount:</span>&nbsp;{{amount}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Charge:</span>&nbsp;{{charge}} {{site_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Conversion Rate:</span>&nbsp;1 {{site_currency}} = {{rate}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Donated:</span>&nbsp;{{method_amount}} {{method_currency}}</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Donated Via:</span>&nbsp;{{method_name}}<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"font-weight: 700;\">Transaction Number:</span>&nbsp;{{trx}}</p><p style=\"\"><span style=\"background-color: var(--bs-card-bg); text-align: var(--bs-body-text-align);\"><b>Rejection Message:</b></span>&nbsp;</p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><span style=\"text-wrap: nowrap; color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: var(--bs-body-font-size); font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{{rejection_message}}</span></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\"><br></p><p style=\"\">We want to assure you that this decision was not taken lightly, and it was made after careful consideration by our team. If you have any questions or concerns regarding this rejection, please don\'t hesitate to reach out to us.</p><p style=\"\">We genuinely appreciate your willingness to support our cause, and we hope this experience doesn\'t deter you from continuing to make a positive impact in the future.</p><p style=\"\">Thank you for your understanding.<br></p><p style=\"font-family: &quot;Public Sans&quot;, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Oxygen, Ubuntu, Cantarell, &quot;Fira Sans&quot;, &quot;Droid Sans&quot;, &quot;Helvetica Neue&quot;, sans-serif;\">Warm regards,</p></div>', 'We regret to inform you that your recent donation to \"{{campaign_name}}\" campaign has been rejected. We apologize for any inconvenience caused.\r\n\r\nDetails:\r\n\r\nAmount: {{amount}} {{site_currency}}\r\nCharge: {{charge}} {{site_currency}}\r\nConversion Rate: 1 {{site_currency}} = {{rate}} {{method_currency}}\r\nDonated: {{method_amount}} {{method_currency}}\r\nDonated Via: {{method_name}}\r\nTransaction Number: {{trx}}\r\n\r\nRejection Message: \r\n{{rejection_message}}\r\n\r\nIf you have any questions or concerns regarding this rejection, please don\'t hesitate to reach out to us. Thank you for your understanding.', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"campaign_name\":\"Name of the campaign\",\"rejection_message\":\"Rejection message by the admin\"}', 1, 1, '2021-11-03 12:00:00', '2024-03-07 06:06:06');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `script` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `shortcode` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'object',
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `act`, `name`, `image`, `script`, `shortcode`, `status`, `created_at`, `updated_at`) VALUES
(1, 'google-analytics', 'Google Analytics', 'analytics.png', '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{app_key}}\"></script>\n                <script>\n                  window.dataLayer = window.dataLayer || [];\n                  function gtag(){dataLayer.push(arguments);}\n                  gtag(\"js\", new Date());\n                \n                  gtag(\"config\", \"{{app_key}}\");\n                </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"-----------------------\"}}', 0, NULL, '2024-06-13 23:18:03'),
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'captcha.png', '\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>', '{\"site_key\":{\"title\":\"Site Key\",\"value\":\"-----------------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"-----------------------\"}}', 0, NULL, '2024-06-14 00:44:53'),
(3, 'facebook-messenger', 'Facebook Messenger', 'messenger.png', '<div id=\"fb-root\"></div>\n<div id=\"fb-customer-chat\" class=\"fb-customerchat\"></div>\n\n<script>\n    var chatbox = document.getElementById(\'fb-customer-chat\');\n    chatbox.setAttribute(\"page_id\", {{page_id}});\n    chatbox.setAttribute(\"attribution\", \"biz_inbox\");\n</script>\n\n<!-- Your SDK code -->\n<script>\n    window.fbAsyncInit = function() {\n    FB.init({\n        xfbml            : true,\n        version          : \'v17.0\'\n    });\n    };\n\n    (function(d, s, id) {\n    var js, fjs = d.getElementsByTagName(s)[0];\n    if (d.getElementById(id)) return;\n    js = d.createElement(s); js.id = id;\n    js.src = \'https://connect.facebook.net/en_US/sdk/xfbml.customerchat.js\';\n    fjs.parentNode.insertBefore(js, fjs);\n    }(document, \'script\', \'facebook-jssdk\'));\n</script>', '{\"page_id\":{\"title\":\"Page Id\",\"value\":\"-----------------\"}}', 0, NULL, '2024-06-13 23:17:52'),
(4, 'tawk-chat', 'Tawk.to', 'tawk.png', '<script>\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\n                        (function(){\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\n                        s1.async=true;\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\n                        s1.charset=\"UTF-8\";\n                        s1.setAttribute(\"crossorigin\",\"*\");\n                        s0.parentNode.insertBefore(s1,s0);\n                        })();\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"-----------------\"}}', 0, NULL, '2024-06-13 23:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `site_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_cur` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'site currency text',
  `cur_sym` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'site currency symbol',
  `per_page_item` int UNSIGNED NOT NULL DEFAULT '20',
  `fraction_digit` tinyint UNSIGNED NOT NULL DEFAULT '2',
  `date_format` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MDY',
  `email_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_template` text COLLATE utf8mb4_unicode_ci,
  `sms_body` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_config` text COLLATE utf8mb4_unicode_ci,
  `sms_config` text COLLATE utf8mb4_unicode_ci,
  `universal_shortcodes` text COLLATE utf8mb4_unicode_ci,
  `first_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `second_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signup` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'user registration',
  `enforce_ssl` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'enforce ssl',
  `agree_policy` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'accept terms and policy',
  `strong_pass` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'enforce strong password',
  `kc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'kyc confirmation',
  `ec` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'email confirmation',
  `ea` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'email alert',
  `sc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'sms confirmation',
  `sa` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'sms alert',
  `site_maintenance` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `language` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `active_theme` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'primary',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `site_name`, `site_cur`, `cur_sym`, `per_page_item`, `fraction_digit`, `date_format`, `email_from`, `email_template`, `sms_body`, `sms_from`, `mail_config`, `sms_config`, `universal_shortcodes`, `first_color`, `second_color`, `signup`, `enforce_ssl`, `agree_policy`, `strong_pass`, `kc`, `ec`, `ea`, `sc`, `sa`, `site_maintenance`, `language`, `active_theme`, `created_at`, `updated_at`) VALUES
(1, 'PinixFund', 'USD', '$', 20, 2, 'd-m-Y', 'info@phinixdigital.com', '<title></title>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n<style type=\"text/css\">\r\n    @media screen {\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: normal;\r\n		  font-weight: 400;\r\n		  src: local(\'Lato Regular\'), local(\'Lato-Regular\'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format(\'woff\');\r\n		}\r\n		\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: normal;\r\n		  font-weight: 700;\r\n		  src: local(\'Lato Bold\'), local(\'Lato-Bold\'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format(\'woff\');\r\n		}\r\n		\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: italic;\r\n		  font-weight: 400;\r\n		  src: local(\'Lato Italic\'), local(\'Lato-Italic\'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format(\'woff\');\r\n		}\r\n		\r\n		@font-face {\r\n		  font-family: \'Lato\';\r\n		  font-style: italic;\r\n		  font-weight: 700;\r\n		  src: local(\'Lato Bold Italic\'), local(\'Lato-BoldItalic\'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format(\'woff\');\r\n		}\r\n    }\r\n    \r\n\r\n    body, table, td, a { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; }\r\n    table, td { mso-table-lspace: 0pt; mso-table-rspace: 0pt; }\r\n    img { -ms-interpolation-mode: bicubic; }\r\n\r\n    img { border: 0; height: auto; line-height: 100%; outline: none; text-decoration: none; }\r\n    table { border-collapse: collapse !important; }\r\n    body { height: 100% !important; margin: 0 !important; padding: 0 !important; width: 100% !important; }\r\n\r\n    a[x-apple-data-detectors] {\r\n        color: inherit !important;\r\n        text-decoration: none !important;\r\n        font-size: inherit !important;\r\n        font-family: inherit !important;\r\n        font-weight: inherit !important;\r\n        line-height: inherit !important;\r\n    }\r\n\r\n    div[style*=\"margin: 16px 0;\"] { margin: 0 !important; }\r\n</style>\r\n\r\n\r\n\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n\r\n    <tbody><tr>\r\n        <td bgcolor=\"black\" align=\"center\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n                <tbody><tr>\r\n                    <td align=\"center\" valign=\"top\" style=\"padding: 40px 10px 40px 10px;\">\r\n                        <a href=\"#0\" target=\"_blank\">\r\n                            <img alt=\"Logo\" src=\"https://phinix.digital/pnixfund/assets/universal/images/logoFavicon/logo_light.png\" width=\"180\" height=\"180\" style=\"display: block;  font-family: \'Lato\', Helvetica, Arial, sans-serif; color: #ffffff; font-size: 18px;\" border=\"0\">\r\n                        </a>\r\n                    </td>\r\n                </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n\r\n    <tr>\r\n        <td bgcolor=\"black\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n                <tbody><tr>\r\n                    <td bgcolor=\"#ffffff\" align=\"center\" valign=\"top\" style=\"padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: \'Lato\', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;\">\r\n                      <h1 style=\"font-size: 22px; font-weight: 400; margin: 0; border-bottom: 1px solid #727272; width: max-content;\">Hello {{fullname}} ({{username}})</h1>\r\n                    </td>\r\n                </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n\r\n    <tr>\r\n        <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n\r\n              <tbody><tr>\r\n                <td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: \'Lato\', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px; text-align: center;\">\r\n                  <p style=\"margin: 0;\">{{message}}</p>\r\n                </td>\r\n              </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n\r\n    <tr>\r\n        <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 30px 10px 0px 10px;\">\r\n            <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"700\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"black\" align=\"center\" style=\"padding: 30px 30px 30px 30px; border-radius: 4px 4px 4px 4px; color: #666666; font-family: \'Lato\', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">\r\n                    <h2 style=\"font-size: 20px; font-weight: 400; color: white; margin: 0;\">©{{site_name}} All Rights Reserved.</h2>\r\n                  </td>\r\n                </tr>\r\n            </tbody></table>\r\n        </td>\r\n    </tr>\r\n</tbody></table>', 'hi {{fullname}} ({{username}}), {{message}}', 'PnixFund', '{\"name\":\"php\"}', '{\"name\":\"custom\",\"nexmo\":{\"api_key\":\"------\",\"api_secret\":\"------\"},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"-----------------------\",\"from\":\"----------------------\"},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\",\"Demo Api\"],\"value\":[\"test_api\",\"Demo Api\"]},\"body\":{\"name\":[\"from_number\",\"Demo bodyt Api\"],\"value\":[\"565754\",\"Demo body API\"]}}}', '{\r\n    \"site_name\":\"Name of your site\",\r\n    \"site_currency\":\"Currency of your site\",\r\n    \"currency_symbol\":\"Symbol of currency\"\r\n}', '47D195', '9DE713', 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 'primary', NULL, '2024-06-13 23:19:33');

-- --------------------------------------------------------

--
-- Table structure for table `site_data`
--

CREATE TABLE `site_data` (
  `id` bigint UNSIGNED NOT NULL,
  `data_key` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_info` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_data`
--

INSERT INTO `site_data` (`id`, `data_key`, `data_info`, `created_at`, `updated_at`) VALUES
(1, 'seo.data', '{\"seo_image\":\"1\",\"keywords\":[\"charity\",\"donation\",\"contribution\",\"crowdfund\",\"crowdfunding\",\"donate\",\"fund\",\"fundraiser\",\"fundraising\",\"give help\",\"help\",\"laravel\",\"php script\",\"raising\",\"script\",\"charity application\",\"crowdfunding-script\",\"crowdfunding-solution\",\"donation script\",\"fundraised\",\"fundraiser script\",\"kickstarter\",\"laravel crowdfunding script\",\"laravel-crowdfunding\",\"php mysql crowdfunding script\",\"php-crowdfunding\",\"ultimate-crowdfunding\",\"campaigns\",\"crowdfunding platform\",\"crowdfunding system\",\"fund raising\",\"fund-raising\",\"campaign\",\"crowd funding\",\"crowd sourcing\",\"donations\",\"fund raiser\",\"funding\",\"fundme\",\"rewards\"],\"social_title\":\"PnixFund\",\"description\":\"Join Charity in creating positive change worldwide. Donate, volunteer, or spread the word to support impactful projects and foster community engagement. Together, let\'s make a difference. Donate now.\",\"social_description\":\"Seeking to champion inspiring ventures and imaginative concepts? Join our crowdfunding platform and become a member of a worldwide network of supporters dedicated to fostering positive change. Through our platform, you\'ll have the opportunity to finance groundbreaking initiatives and contribute to the realization of exceptional ideas. Embrace the opportunity today and begin crowdfunding for a brighter future!\",\"image\":\"66693a659c1d91718172261.png\"}', '2023-08-15 14:11:35', '2024-06-12 06:04:21'),
(3, 'about.content', '{\"has_image\":\"1\",\"heading\":\"Together We Fund, Together We Flourish\",\"description\":\"Welcome to PnixFund, your go-to platform for meaningful crowdfunding. At PnixFund, we\'re driven by a simple yet powerful mission: to empower individuals, organizations, and communities to create positive change through collective action and generosity. We\'re more than just a platform \\u2013 we\'re a community of compassionate individuals dedicated to making a difference.\",\"button_text\":\"Learn More\",\"button_url\":\"success-stories\",\"background_image\":\"65b2340b51b391706177547.jpg\",\"image\":\"65b2204867fb71706172488.png\"}', '2023-09-23 13:19:27', '2024-03-28 02:10:31'),
(8, 'cookie.data', '{\"short_details\":\"We may use cookies or any other tracking technologies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the Site and improve your experience.\",\"details\":\"<div style=\\\"margin: 0px; padding: 0px; color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 16px;\\\"><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: x-large;\\\">Types of information we gather<\\/span><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><font size=\\\"5\\\" style=\\\"margin: 0px; padding: 0px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Personal Information:<\\/span>&nbsp;When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/span><\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Campaign Information:<\\/span>&nbsp;We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/span><\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Donation Information:<\\/span>&nbsp;For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/span><\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Usage Data:<\\/span>&nbsp;We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/span><\\/font><\\/div><\\/div><\\/div><h5 style=\\\"margin-right: 0px; margin-bottom: 0.5rem; margin-left: 0px; padding: 0px; font-weight: 600; line-height: 1.3; color: hsl(var(--black)\\/0.6); font-size: clamp(1.125rem, 0.7784rem + 0.722vw, 1.5rem); font-family: var(--heading-font);\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/h5><h4 style=\\\"margin-right: 0px; margin-bottom: 0.5rem; margin-left: 0px; padding: 0px; font-weight: 600; line-height: 1.3; color: hsl(var(--black)\\/0.6); font-size: clamp(1.25rem, 0.5569rem + 1.444vw, 2rem); font-family: var(--heading-font);\\\"><\\/h4><div style=\\\"margin: 0px; padding: 0px; color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 16px;\\\"><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><font size=\\\"5\\\" style=\\\"margin: 0px; padding: 0px;\\\">Ensuring the security of your information<\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><div style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">User Accounts:<\\/span>&nbsp;We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">Campaign Data:<\\/span>&nbsp;Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">Donation Records:<\\/span>&nbsp;Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><font size=\\\"5\\\" style=\\\"margin: 0px; padding: 0px;\\\">Is any information shared with external parties?<\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><font size=\\\"5\\\" style=\\\"margin: 0px; padding: 0px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">No, we do not sell,<\\/span>&nbsp;trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Exceptional Circumstances:<\\/span>&nbsp;We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><font size=\\\"5\\\" style=\\\"margin: 0px; padding: 0px;\\\">Duration of information retention<\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">User Accounts:<\\/span>&nbsp;We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Campaign Data:<\\/span>&nbsp;Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; font-weight: bolder;\\\">Donation Records:<\\/span>&nbsp;Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: x-large;\\\">Our policies regarding data usage<\\/span><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/div><div style=\\\"margin: 0px; padding: 0px; color: rgb(105, 122, 141); font-size: 15px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-size: x-large;\\\"><br style=\\\"margin: 0px; padding: 0px;\\\"><\\/span><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px;\\\"><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">Personal Information:<\\/span>&nbsp;When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">Campaign Information:<\\/span>&nbsp;We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">Donation Information:<\\/span>&nbsp;For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/font><\\/div><div style=\\\"margin: 0px; padding: 0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin: 0px; padding: 0px;\\\"><span style=\\\"margin: 0px; padding: 0px; display: inline-block; font-weight: 700;\\\">Usage Data:<\\/span>&nbsp;We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/font><\\/div><\\/div><\\/div><\\/div><\\/div><\\/div><\\/div>\",\"status\":1}', NULL, '2024-03-24 11:43:12'),
(9, 'maintenance.data', '{\"heading\":\"Website Under Maintenance\",\"details\":\"<p>We\'re currently sprucing things up to provide you with an even better browsing experience. Our website is temporarily undergoing maintenance, but we\'ll be back online shortly.<\\/p><p>&nbsp;<\\/p><p>In the meantime, if you have any urgent inquiries or need assistance, feel free to reach out to us at <strong>example@example.com<\\/strong>. We apologize for any inconvenience caused and appreciate your patience.<br>&nbsp;<\\/p><p>&nbsp;<\\/p><p>Thank you for your understanding!<\\/p>\"}', NULL, '2024-06-14 05:07:33'),
(11, 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<h4><\\/h4><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\">Types of information we gather<\\/span><br \\/><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><b>Personal Information:<\\/b> When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/span><\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><b>Campaign Information:<\\/b> We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/span><\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><b>Donation Information:<\\/b> For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/span><\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><b>Usage Data:<\\/b> We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/span><\\/font><\\/div><\\/div><\\/div><h5><br \\/><\\/h5><h4><\\/h4><div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\">Ensuring the security of your information<\\/font><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><div><span style=\\\"font-weight:700;\\\">User Accounts:<\\/span>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div><span style=\\\"font-weight:700;\\\">Campaign Data:<\\/span>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div><span style=\\\"font-weight:700;\\\">Donation Records:<\\/span>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div><br \\/><\\/div><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\">Is any information shared with external parties?<\\/font><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><b>No, we do not sell,<\\/b> trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><b>Exceptional Circumstances:<\\/b> We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\">Duration of information retention<\\/font><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><b>User Accounts:<\\/b> We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><b>Campaign Data:<\\/b> Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><b>Donation Records:<\\/b> Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\">Our policies regarding data usage<\\/span><br \\/><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\"><br \\/><\\/span><\\/div><div><div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Personal Information:<\\/span>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Campaign Information:<\\/span>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Donation Information:<\\/span>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Usage Data:<\\/span>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/font><\\/div><\\/div><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\"><br \\/><\\/span><\\/div><\\/div><\\/div><\\/div><\\/div>\"}', '2023-11-09 10:17:26', '2024-03-24 11:41:34'),
(12, 'policy_pages.element', '{\"title\":\"Terms of Service\",\"details\":\"<h4><\\/h4><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\">Types of information we gather<\\/span><br \\/><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Personal Information:<\\/span>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/span><\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Campaign Information:<\\/span>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/span><\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Donation Information:<\\/span>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/span><\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Usage Data:<\\/span>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/span><\\/font><\\/div><\\/div><\\/div><h5><br \\/><\\/h5><h4><\\/h4><h4><\\/h4><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\">Ensuring the security of your information<\\/font><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><div><span style=\\\"font-weight:700;\\\">User Accounts:<\\/span>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div><span style=\\\"font-weight:700;\\\">Campaign Data:<\\/span>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div><span style=\\\"font-weight:700;\\\">Donation Records:<\\/span>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\">Is any information shared with external parties?<\\/font><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">No, we do not sell,<\\/span>\\u00a0trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Exceptional Circumstances:<\\/span>\\u00a0We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\">Duration of information retention<\\/font><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">User Accounts:<\\/span>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Campaign Data:<\\/span>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-weight:700;\\\">Donation Records:<\\/span>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><br \\/><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\">Our policies regarding data usage<\\/span><br \\/><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"font-size:x-large;\\\"><br \\/><\\/span><\\/div><div style=\\\"color:rgb(105,122,141);font-size:15px;\\\"><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Personal Information:<\\/span>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Campaign Information:<\\/span>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Donation Information:<\\/span>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/font><\\/div><div><font color=\\\"#697a8d\\\"><span style=\\\"font-weight:700;\\\">Usage Data:<\\/span>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/font><\\/div><\\/div><\\/div><\\/div><\\/div>\"}', '2023-11-09 10:17:51', '2024-03-24 11:39:15'),
(14, 'banner.element', '{\"has_image\":\"1\",\"title\":\"Pledge for Progress\",\"heading\":\"Empowering Dreams, One Backing at a Time\",\"short_description\":\"We provide a platform for individuals, organizations, and causes to create fundraising campaigns and garner support from a global community of donors.\",\"first_button_text\":\"Join With Us\",\"first_button_url\":\"user\\/register\",\"second_button_text\":\"Explore Campaign\",\"second_button_url\":\"campaigns\",\"background_image\":\"65b2056b8623d1706165611.jpg\"}', '2024-01-25 06:53:31', '2024-03-28 02:08:37'),
(15, 'banner.element', '{\"has_image\":\"1\",\"title\":\"Join the Backing Revolution\",\"heading\":\"Backing Visionaries, Building Tomorrow\",\"short_description\":\"We enable users to raise funds for a diverse range of needs, including medical expenses, educational pursuits, community projects, disaster relief efforts, and more.\",\"first_button_text\":\"Join With Us\",\"first_button_url\":\"user\\/register\",\"second_button_text\":\"Explore Campaign\",\"second_button_url\":\"campaigns\",\"background_image\":\"65b20636395661706165814.jpg\"}', '2024-01-25 06:56:54', '2024-03-28 02:09:00'),
(16, 'banner.element', '{\"has_image\":\"1\",\"title\":\"Back, Believe, Build\",\"heading\":\"Where Ideas Take Flight, Fueled by You\",\"short_description\":\"We emphasize transparency by allowing campaign creators to set clear goals, share their stories, and provide updates on the progress of their campaigns. Donors can track how their contributions are making an impact.\",\"first_button_text\":\"Join With Us\",\"first_button_url\":\"user\\/register\",\"second_button_text\":\"Explore Campaign\",\"second_button_url\":\"campaigns\",\"background_image\":\"65b2068a2840e1706165898.jpg\"}', '2024-01-25 06:58:18', '2024-03-28 02:09:42'),
(17, 'featured_campaign.content', '{\"section_heading\":\"Featured Campaign\",\"description\":\"Discover our handpicked selection of featured campaigns, curated to showcase the most impactful and inspiring initiatives.\"}', '2024-01-25 10:33:22', '2024-03-15 15:57:10'),
(18, 'volunteer.content', '{\"section_heading\":\"Discover Our Volunteer\",\"description\":\"Join our passionate community of volunteers through our dedicated volunteers.\"}', '2024-01-25 10:53:52', '2024-03-15 16:24:42'),
(19, 'volunteer.element', '{\"has_image\":\"1\",\"name\":\"Michael Mishler\",\"participated\":\"10\",\"from\":\"United States\",\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\",\"volunteer_image\":\"65b23e875768d1706180231.jpg\"}', '2024-01-25 10:57:11', '2024-03-13 03:59:49'),
(20, 'volunteer.element', '{\"has_image\":\"1\",\"name\":\"Phillip Hawkes\",\"participated\":\"20\",\"from\":\"Germany\",\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\",\"volunteer_image\":\"65b23e9fd081e1706180255.jpg\"}', '2024-01-25 10:57:35', '2024-03-13 04:00:44'),
(21, 'volunteer.element', '{\"has_image\":\"1\",\"name\":\"Howard Buxton\",\"participated\":\"30\",\"from\":\"Canada\",\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\",\"volunteer_image\":\"65b23eb0ba4ae1706180272.jpg\"}', '2024-01-25 10:57:52', '2024-03-13 04:01:25'),
(22, 'volunteer.element', '{\"has_image\":\"1\",\"name\":\"Harvey Olivarez\",\"participated\":\"40\",\"from\":\"Denmark\",\"facebook\":\"https:\\/\\/www.facebook.com\\/\",\"twitter\":\"https:\\/\\/twitter.com\\/\",\"instagram\":\"https:\\/\\/www.instagram.com\\/\",\"linkedin\":\"https:\\/\\/www.linkedin.com\\/\",\"volunteer_image\":\"65b23ec00f1281706180288.jpg\"}', '2024-01-25 10:58:08', '2024-03-13 04:02:03'),
(23, 'counter.element', '{\"title\":\"Total Volunteer\",\"counter_digit\":\"1203\"}', '2024-01-25 11:33:01', '2024-01-25 11:33:01'),
(24, 'counter.element', '{\"title\":\"Total Campaign\",\"counter_digit\":\"3627\"}', '2024-01-25 11:38:15', '2024-03-15 15:53:26'),
(25, 'counter.element', '{\"title\":\"Total Success Story\",\"counter_digit\":\"2785\"}', '2024-01-25 11:38:26', '2024-03-15 15:53:18'),
(26, 'counter.element', '{\"title\":\"Total Event\",\"counter_digit\":\"1596\"}', '2024-01-25 11:38:39', '2024-03-15 15:53:43'),
(27, 'breadcrumb.content', '{\"has_image\":\"1\",\"background_image\":\"65b24f623fe111706184546.png\"}', '2024-01-25 12:09:06', '2024-01-25 12:09:07'),
(28, 'client_review.content', '{\"section_heading\":\"Client\\u2019s Review\",\"description\":\"Discover what our valued clients have to say about their experiences with us. Browse through authentic reviews and testimonials that highlight the quality of our services.\"}', '2024-01-28 04:54:05', '2024-03-15 14:53:44'),
(29, 'client_review.element', '{\"has_image\":\"1\",\"client_name\":\"Donald Hayman\",\"client_designation\":\"CEO & Founder\",\"client_review\":\"Working with Charity was an absolute game-changer for our campaign. Their innovative approach, attention to detail, and unwavering dedication truly exceeded our expectations. Not only did they help us achieve our goals, but they also made the entire process seamless and enjoyable.\",\"client_image\":\"65b5de61abb9a1706417761.jpg\"}', '2024-01-28 04:56:01', '2024-03-15 15:46:32'),
(30, 'client_review.element', '{\"has_image\":\"1\",\"client_name\":\"John Doe\",\"client_designation\":\"Web Developer\",\"client_review\":\"Choosing Charity for our campaign was the best decision we made. Their team\'s professionalism and creativity brought our vision to life in ways we never imagined. From the initial brainstorming sessions to the final execution, they were with us every step of the way, ensuring every detail was perfect.\",\"client_image\":\"65b5dea35d3a51706417827.jpg\"}', '2024-01-28 04:57:07', '2024-03-15 15:46:07'),
(31, 'client_review.element', '{\"has_image\":\"1\",\"client_name\":\"Mark Smith\",\"client_designation\":\"Web Designer\",\"client_review\":\"Our experience with Charity was nothing short of exceptional. Their strategic approach and commitment to our campaign\'s success were evident from day one. What stood out most was their ability to understand our objectives and tailor their solutions to meet our specific needs.\",\"client_image\":\"65b5ded10c2a91706417873.jpg\"}', '2024-01-28 04:57:53', '2024-03-15 15:48:59'),
(32, 'partner.element', '{\"image\":\"66683e65b49c51718107749.png\"}', '2024-01-28 05:46:04', '2024-06-11 12:09:09'),
(33, 'partner.element', '{\"image\":\"66683e7cdc6911718107772.png\"}', '2024-01-28 05:46:18', '2024-06-11 12:09:32'),
(34, 'partner.element', '{\"image\":\"66683e92e0e501718107794.png\"}', '2024-01-28 05:46:27', '2024-06-11 12:09:54'),
(35, 'partner.element', '{\"image\":\"66683ea5d7f841718107813.png\"}', '2024-01-28 05:46:37', '2024-06-11 12:10:13'),
(36, 'partner.element', '{\"image\":\"66683ebc90a9b1718107836.png\"}', '2024-01-28 05:46:48', '2024-06-11 12:10:36'),
(37, 'partner.element', '{\"image\":\"66683ed022cfd1718107856.png\"}', '2024-01-28 05:46:58', '2024-06-11 12:10:56'),
(38, 'faq.content', '{\"section_heading\":\"Frequently Asked Question\",\"description\":\"Find quick answers to commonly asked questions on our FAQ page. From inquiries about our services to details on how to get started.\"}', '2024-01-28 06:18:23', '2024-03-15 15:54:53'),
(39, 'faq.element', '{\"question\":\"What is crowdfunding?\",\"answer\":\"Crowdfunding is a method of raising funds from a large number of people, typically via online platforms. It allows individuals, businesses, or organizations to present their projects, causes, or ventures to a wide audience, inviting contributions from interested individuals, known as backers or supporters.<br \\/>\"}', '2024-01-28 06:19:09', '2024-01-28 06:19:09'),
(40, 'faq.element', '{\"question\":\"How does crowdfunding work?\",\"answer\":\"Crowdfunding involves creating a campaign that outlines the details of a project or cause, including its purpose, goals, and often, rewards for backers. Supporters can then contribute financially to the campaign through the crowdfunding platform. If the funding goal is reached within a specified timeframe, the project is funded, and funds are typically released to the campaign creator.<br \\/>\"}', '2024-01-28 06:19:39', '2024-01-28 06:19:39'),
(41, 'faq.element', '{\"question\":\"What types of crowdfunding are there?\",\"answer\":\"There are various types of crowdfunding, including reward-based (backers receive non-financial incentives), equity-based (backers receive a share of the project), donation-based (contributors give without expecting anything in return), and debt-based (backers lend money to the project, expecting repayment with interest).<br \\/>\"}', '2024-01-28 06:20:10', '2024-01-28 06:20:10'),
(42, 'faq.element', '{\"question\":\"What are the benefits of crowdfunding?\",\"answer\":\"Crowdfunding offers a democratized approach to funding, allowing creators to access capital from a broad audience. It also provides a platform for testing market interest, building a community around a project, and gaining early support and validation.<br \\/>\"}', '2024-01-28 06:20:40', '2024-01-28 06:20:40'),
(44, 'faq.element', '{\"question\":\"Are there risks involved in crowdfunding?\",\"answer\":\"Yes, there are risks associated with crowdfunding. Contributors may not receive the promised rewards or returns, and projects may not be completed as planned. Due diligence is crucial for both creators and backers to minimize these risks.<br \\/>\"}', '2024-01-28 06:22:02', '2024-01-28 06:22:02'),
(47, 'contact_us.content', '{\"section_heading\":\"Get In Touch With Us\",\"description\":\"Connect with us easily through our \'Contact Us\' page. Reach out for inquiries, collaborations, or any assistance you may need.\",\"form_heading\":\"We are waiting to hear from you\",\"form_button_name\":\"Send Message\",\"latitude\":\"25.7907\\u00b0 N\",\"longitude\":\"80.1300\\u00b0 W\"}', '2024-01-28 07:22:17', '2024-03-20 11:51:02'),
(48, 'contact_us.element', '{\"icon\":\"<i class=\\\"ti ti-map-pin\\\"><\\/i>\",\"heading\":\"Address\",\"data\":\"USA, Florida, 100 Old City House\"}', '2024-01-28 08:41:57', '2024-06-11 11:53:40'),
(49, 'contact_us.element', '{\"icon\":\"<i class=\\\"ti ti-mail\\\"><\\/i>\",\"heading\":\"Email Address\",\"data\":\"example@example.com\"}', '2024-01-28 08:44:00', '2024-06-11 11:53:18'),
(50, 'contact_us.element', '{\"icon\":\"<i class=\\\"ti ti-phone\\\"><\\/i>\",\"heading\":\"Phone\",\"data\":\"+1234 567 890\"}', '2024-01-28 08:46:13', '2024-06-11 11:52:52'),
(51, 'footer.content', '{\"footer_text\":\"Join our community and be part of the change. Follow us on social media for updates, success stories, and more. Make a difference.\",\"copyright_text\":\"\\u00a9 Copyright 2024. All rights reserved.\"}', '2024-01-28 10:51:36', '2024-03-24 12:54:47'),
(52, 'footer.element', '{\"social_icon\":\"<i class=\\\"ti ti-brand-facebook\\\"><\\/i>\",\"url\":\"https:\\/\\/www.facebook.com\\/\"}', '2024-01-28 10:52:44', '2024-06-11 11:54:46'),
(53, 'footer.element', '{\"social_icon\":\"<i class=\\\"ti ti-brand-x\\\"><\\/i>\",\"url\":\"https:\\/\\/twitter.com\\/\"}', '2024-01-28 10:56:10', '2024-06-11 11:55:09'),
(54, 'footer.element', '{\"social_icon\":\"<i class=\\\"ti ti-brand-linkedin\\\"><\\/i>\",\"url\":\"https:\\/\\/www.linkedin.com\\/\"}', '2024-01-28 11:01:24', '2024-06-11 11:55:30'),
(55, 'footer.element', '{\"social_icon\":\"<i class=\\\"ti ti-brand-instagram\\\"><\\/i>\",\"url\":\"https:\\/\\/www.instagram.com\\/\"}', '2024-01-28 11:02:20', '2024-06-11 11:55:50'),
(56, 'login.content', '{\"form_heading\":\"Sign in to your account\",\"submit_button_text\":\"Log In\",\"background_image\":\"65b74764a461f1706510180.png\",\"image\":\"66693754f2bc81718171476.png\"}', '2024-01-29 06:36:20', '2024-06-12 05:51:17'),
(57, 'register.content', '{\"form_heading\":\"Create new account\",\"submit_button_text\":\"Sign Up\",\"background_image\":\"65b74f51b34751706512209.png\",\"image\":\"666937f5e8f661718171637.png\"}', '2024-01-29 07:10:09', '2024-06-12 05:53:57'),
(58, 'kyc.content', '{\"verification_required_heading\":\"Verification Needed\",\"verification_required_details\":\"Ensure your account security and access exclusive features by providing the necessary verification details.\",\"verification_pending_heading\":\"Verification Pending\",\"verification_pending_details\":\"Your request for verification is in progress. We appreciate your patience as we ensure the security of your account.\"}', '2024-01-29 10:35:38', '2024-03-17 09:13:03'),
(59, 'forgot_password.content', '{\"form_heading\":\"Recover your account\",\"submit_button_text\":\"Next\",\"background_image\":\"65b889ba49ef11706592698.png\",\"image\":\"6669372bc9d1f1718171435.png\"}', '2024-01-30 05:31:38', '2024-06-12 05:50:35'),
(60, 'code_verification.content', '{\"form_heading\":\"Enter the verification code\",\"submit_button_text\":\"Submit\",\"background_image\":\"65b89466d3f5f1706595430.png\",\"image\":\"666936a9ea2ab1718171305.png\"}', '2024-01-30 06:17:10', '2024-06-12 05:48:26'),
(61, 'password_reset.content', '{\"form_heading\":\"Reset your password\",\"submit_button_text\":\"Submit\",\"background_image\":\"65b8a0de319171706598622.png\",\"image\":\"666937b49c3d81718171572.png\"}', '2024-01-30 07:10:22', '2024-06-12 05:52:52'),
(62, 'email_confirm.content', '{\"form_heading\":\"Verify your email address\",\"submit_button_text\":\"Submit\",\"background_image\":\"65b8c50552abc1706607877.png\",\"image\":\"666936efc7a541718171375.png\"}', '2024-01-30 09:44:37', '2024-06-12 05:49:35'),
(63, 'mobile_confirm.content', '{\"form_heading\":\"Verify your phone number\",\"submit_button_text\":\"Submit\",\"background_image\":\"65b8cad7221bf1706609367.png\",\"image\":\"666937822618d1718171522.png\"}', '2024-01-30 10:09:27', '2024-06-12 05:52:02'),
(64, 'user_ban.content', '{\"form_heading\":\"You are banned\",\"background_image\":\"65b8d184a65391706611076.png\",\"image\":\"66693891b66eb1718171793.png\"}', '2024-01-30 10:37:56', '2024-06-12 05:56:33'),
(65, '2fa_confirm.content', '{\"form_heading\":\"Verify two factor authentication\",\"submit_button_text\":\"Submit\",\"background_image\":\"65b8e90fe5ee11706617103.png\",\"image\":\"666936560bce51718171222.png\"}', '2024-01-30 12:18:23', '2024-06-12 05:47:02'),
(66, 'campaign_category.content', '{\"section_heading\":\"Campaign Category\",\"description\":\"Explore our diverse campaign categories, each tailored to meet your specific needs and interests.\"}', '2024-02-03 06:31:04', '2024-03-15 14:49:52'),
(67, 'recent_campaign.content', '{\"section_heading\":\"Our Recent Initiatives\",\"description\":\"Discover the pulse of our efforts with our recent campaigns. Dive into our most current initiatives.\"}', '2024-02-08 06:59:23', '2024-03-15 16:04:23'),
(68, 'upcoming.content', '{\"section_heading\":\"Upcoming Campaigns\",\"description\":\"Anticipate the future of change with our upcoming campaigns. Stay ahead of the curve as we unveil our latest initiatives.\"}', '2024-03-12 11:04:20', '2024-03-15 16:22:30'),
(69, 'success_story.content', '{\"section_heading\":\"Success Stories\",\"description\":\"Unlock inspiration and motivation in our success story. Immerse yourself in tales of triumph, where dreams become reality.\"}', '2024-03-13 10:20:52', '2024-03-15 16:07:04'),
(70, 'success_story.element', '{\"has_image\":\"1\",\"title\":\"Clean Water, Thriving Communities: A Tale of Watershed Restoration\",\"details\":\"<div>The \\\"Empower Her\\\" campaign aims to support women entrepreneurs worldwide by providing them with access to resources, mentorship, and funding opportunities. Women entrepreneurs face numerous challenges, including limited access to capital and resources. This fund seeks to level the playing field by empowering women to start and grow their businesses, ultimately driving economic growth and gender equality.<div><div><br \\/><\\/div><div><font size=\\\"5\\\">The campaign began with a group<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>The campaign began with a group of passionate individuals who were deeply troubled by the mountains of waste piling up in landfills and littering the streets. They saw an opportunity to not only address the environmental impact of waste but also to create economic opportunities for marginalized communities.<br \\/><h5><br \\/><\\/h5><div><font size=\\\"5\\\">Raising awareness about the importance<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div>Recycle Revolution kicked off with a door-to-door education campaign, raising awareness about the importance of recycling and the potential benefits it held for the community. Volunteers distributed informational pamphlets, conducted workshops, and engaged residents in conversations about waste reduction and resource conservation.<\\/div><div><br \\/><\\/div><div><font size=\\\"5\\\">Recycling centers in strategic locations<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>Inspired by the response from the community, Recycle Revolution set up recycling centers in strategic locations throughout the city. These centers served as hubs for collecting, sorting, and processing recyclable materials, providing jobs and income for local residents who were trained to operate the facilities.<\\/div><\\/div><\\/div>\",\"image\":\"65f18128bf4ef1710326056.jpg\"}', '2024-03-13 10:34:16', '2024-03-25 05:24:32'),
(71, 'success_story.element', '{\"has_image\":\"1\",\"title\":\"Planting for Tomorrow: Transforming Communities Through Tree Conservation\",\"details\":\"<div>Donations to this campaign will directly support women-owned businesses, enabling them to thrive and contribute to their communities\' economic development. By empowering women entrepreneurs, we can create a more equitable and inclusive society where everyone has the opportunity to succeed.<div><div><br \\/><\\/div><div><font size=\\\"5\\\">The campaign began with a group<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>The campaign began with a group of passionate individuals who were deeply troubled by the mountains of waste piling up in landfills and littering the streets. They saw an opportunity to not only address the environmental impact of waste but also to create economic opportunities for marginalized communities.<br \\/><h5><br \\/><\\/h5><div><font size=\\\"5\\\">Raising awareness about the importance<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div>Recycle Revolution kicked off with a door-to-door education campaign, raising awareness about the importance of recycling and the potential benefits it held for the community. Volunteers distributed informational pamphlets, conducted workshops, and engaged residents in conversations about waste reduction and resource conservation.<\\/div><div><br \\/><\\/div><div><font size=\\\"5\\\">Recycling centers in strategic locations<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>Inspired by the response from the community, Recycle Revolution set up recycling centers in strategic locations throughout the city. These centers served as hubs for collecting, sorting, and processing recyclable materials, providing jobs and income for local residents who were trained to operate the facilities.<\\/div><\\/div><\\/div>\",\"image\":\"65f181b0108ad1710326192.jpg\"}', '2024-03-13 10:36:32', '2024-03-25 05:24:48'),
(72, 'success_story.element', '{\"has_image\":\"1\",\"title\":\"Sustainable Seas: A Success Story of Community-Led Marine Conservation\",\"details\":\"The \\\"Clean Water for All\\\" campaign aims to provide access to clean water, improved hygiene, and sanitation facilities to communities in need. Access to clean water is a fundamental human right, yet millions of people around the world lack access to safe drinking water and proper sanitation. This project seeks to address this issue by implementing water purification systems, building latrines, and promoting hygiene education.<div><div><br \\/><\\/div><div><font size=\\\"5\\\">The campaign began with a group<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>The campaign began with a group of passionate individuals who were deeply troubled by the mountains of waste piling up in landfills and littering the streets. They saw an opportunity to not only address the environmental impact of waste but also to create economic opportunities for marginalized communities.<br \\/><h5><br \\/><\\/h5><div><font size=\\\"5\\\">Raising awareness about the importance<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div>Recycle Revolution kicked off with a door-to-door education campaign, raising awareness about the importance of recycling and the potential benefits it held for the community. Volunteers distributed informational pamphlets, conducted workshops, and engaged residents in conversations about waste reduction and resource conservation.<\\/div><div><br \\/><\\/div><div><font size=\\\"5\\\">Recycling centers in strategic locations<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>Inspired by the response from the community, Recycle Revolution set up recycling centers in strategic locations throughout the city. These centers served as hubs for collecting, sorting, and processing recyclable materials, providing jobs and income for local residents who were trained to operate the facilities.<\\/div><\\/div>\",\"image\":\"65f181d25202c1710326226.jpg\"}', '2024-03-13 10:37:06', '2024-03-25 05:25:09'),
(76, 'success_story.element', '{\"has_image\":\"1\",\"title\":\"From Waste to Wealth: Empowering Communities Through Recycling\",\"details\":\"Donations to this campaign will help deploy rapid response teams and provide critical aid to affected communities, helping them recover and rebuild in the aftermath of disasters. By coming together as a global community, we can save lives and alleviate suffering during times of crisis.<div><div><br \\/><\\/div><div><font size=\\\"5\\\">The campaign began with a group<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>  \\r\\nThe campaign began with a group of passionate individuals who were deeply troubled by the mountains of waste piling up in landfills and littering the streets. They saw an opportunity to not only address the environmental impact of waste but also to create economic opportunities for marginalized communities.\\r\\n<br \\/><h5><br \\/><\\/h5><div><font size=\\\"5\\\">Raising awareness about the importance<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div>  \\r\\nRecycle Revolution kicked off with a door-to-door education campaign, raising awareness about the importance of recycling and the potential benefits it held for the community. Volunteers distributed informational pamphlets, conducted workshops, and engaged residents in conversations about waste reduction and resource conservation.<\\/div><div><br \\/><\\/div><div><font size=\\\"5\\\">Recycling centers in strategic locations<\\/font><\\/div><div><font size=\\\"5\\\"><br \\/><\\/font><\\/div><div>  \\r\\nInspired by the response from the community, Recycle Revolution set up recycling centers in strategic locations throughout the city. These centers served as hubs for collecting, sorting, and processing recyclable materials, providing jobs and income for local residents who were trained to operate the facilities.<\\/div><\\/div>\",\"image\":\"65f2c4548cf391710408788.jpg\"}', '2024-03-14 09:33:08', '2024-03-25 05:25:33'),
(77, 'top_donor.content', '{\"section_heading\":\"Our Top Donors\",\"description\":\"Explore the individuals and organizations who have gone above and beyond to support our cause.\",\"background_image\":\"66693868428e91718171752.png\"}', '2024-03-15 14:36:01', '2024-06-12 05:55:52'),
(80, 'subscribe.content', '{\"section_heading\":\"Subscribe Our Newsletter\",\"description\":\"Stay Updated! Subscribe to Our Newsletter for more campaigns, and Special Promotions. You can also contribute values to humanity\",\"submit_button_text\":\"Subscribe Now\",\"background_image\":\"66693821939aa1718171681.png\"}', '2024-03-20 11:03:04', '2024-06-12 05:54:41');
INSERT INTO `site_data` (`id`, `data_key`, `data_info`, `created_at`, `updated_at`) VALUES
(82, 'policy_pages.element', '{\"title\":\"Support Policy\",\"details\":\"<div style=\\\"margin:0px;padding:0px;color:rgb(33,37,41);font-family:\'Open Sans\', sans-serif;font-size:16px;\\\"><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:x-large;\\\">Types of information we gather<\\/span><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\" style=\\\"margin:0px;padding:0px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Personal Information:<\\/span>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/span><\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Campaign Information:<\\/span>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/span><\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Donation Information:<\\/span>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/span><\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Usage Data:<\\/span>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/span><\\/font><\\/div><\\/div><\\/div><h5 style=\\\"margin-right:0px;margin-bottom:0.5rem;margin-left:0px;padding:0px;font-weight:600;line-height:1.3;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/h5><h4 style=\\\"margin-right:0px;margin-bottom:0.5rem;margin-left:0px;padding:0px;font-weight:600;line-height:1.3;\\\"><\\/h4><div style=\\\"margin:0px;padding:0px;color:rgb(33,37,41);font-family:\'Open Sans\', sans-serif;font-size:16px;\\\"><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\" style=\\\"margin:0px;padding:0px;\\\">Ensuring the security of your information<\\/font><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><div style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">User Accounts:<\\/span>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">Campaign Data:<\\/span>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">Donation Records:<\\/span>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div style=\\\"margin:0px;padding:0px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\" style=\\\"margin:0px;padding:0px;\\\">Is any information shared with external parties?<\\/font><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\" style=\\\"margin:0px;padding:0px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">No, we do not sell,<\\/span>\\u00a0trade, or otherwise transfer users\' personally identifiable information to outside parties without explicit consent.<\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Exceptional Circumstances:<\\/span>\\u00a0We may disclose user information in response to legal requirements, enforcement of policies, or protection of rights, property, or safety.<\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><font size=\\\"5\\\" style=\\\"margin:0px;padding:0px;\\\">Duration of information retention<\\/font><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">User Accounts:<\\/span>\\u00a0We retain user account information for as long as the account remains active or until the user requests its deletion.<\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Campaign Data:<\\/span>\\u00a0Campaign information is retained for a reasonable period after the campaign\'s conclusion to facilitate auditing, reporting, and dispute resolution.<\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:bolder;\\\">Donation Records:<\\/span>\\u00a0Donation records are retained for compliance purposes and may be stored for a period required by applicable laws or regulations.<\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:x-large;\\\">Our policies regarding data usage<\\/span><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/div><div style=\\\"margin:0px;padding:0px;color:rgb(105,122,141);font-size:15px;\\\"><span style=\\\"margin:0px;padding:0px;font-size:x-large;\\\"><br style=\\\"margin:0px;padding:0px;\\\" \\/><\\/span><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;\\\"><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">Personal Information:<\\/span>\\u00a0When users register on PnixFund, we collect basic personal details such as name, email address, and optionally, profile pictures.<\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">Campaign Information:<\\/span>\\u00a0We collect information provided by campaign creators, including campaign descriptions, goals, and supporting media content.<\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">Donation Information:<\\/span>\\u00a0For donation processing, we collect payment details such as credit card information or payment gateway credentials.<\\/font><\\/div><div style=\\\"margin:0px;padding:0px;\\\"><font color=\\\"#697a8d\\\" style=\\\"margin:0px;padding:0px;\\\"><span style=\\\"margin:0px;padding:0px;font-weight:700;\\\">Usage Data:<\\/span>\\u00a0We may collect non-personal information related to user interactions with the platform, such as IP addresses, browser type, and device identifiers.<\\/font><\\/div><\\/div><\\/div><\\/div><\\/div><\\/div><\\/div>\"}', '2024-03-24 11:44:04', '2024-03-24 11:44:04'),
(83, 'footer.element', '{\"social_icon\":\"<i class=\\\"ti ti-brand-youtube\\\"><\\/i>\",\"url\":\"https:\\/\\/youtube.com\"}', '2024-03-24 12:57:15', '2024-06-11 11:56:12');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `post_balance` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `trx_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_by` int UNSIGNED NOT NULL DEFAULT '0',
  `balance` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0: banned, 1: active',
  `kyc_data` text COLLATE utf8mb4_unicode_ci,
  `kc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: KYC unconfirmed, 2: KYC pending, 1: KYC confirmed',
  `ec` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: email unconfirmed, 1: email confirmed',
  `sc` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: mobile unconfirmed, 1: mobile confirmed',
  `ver_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0: 2fa off, 1: 2fa on',
  `tc` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0: 2fa unconfirmed, 1: 2fa confirmed',
  `tsc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ban_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint UNSIGNED NOT NULL,
  `method_id` int UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `after_charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `withdraw_information` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=>success, 2=>pending, 3=>cancel,  ',
  `admin_feedback` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_methods`
--

CREATE TABLE `withdraw_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `form_id` int UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amount` decimal(28,8) DEFAULT '0.00000000',
  `max_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `fixed_charge` decimal(28,8) DEFAULT '0.00000000',
  `rate` decimal(28,8) DEFAULT '0.00000000',
  `percent_charge` decimal(5,2) DEFAULT NULL,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guideline` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site_data`
--
ALTER TABLE `site_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_data`
--
ALTER TABLE `site_data`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
