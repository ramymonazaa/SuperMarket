#include <bits/stdc++.h>

using namespace std;

struct BigInt {
#define CUR (*this)
    const int BASE = 2;
    string v;

    BigInt() {
    }

    BigInt(string s) {
        v = s;
        reverse(v.begin(), v.end());
        while (v.size() && v.back() == 0)
            v.pop_back();
    }

    BigInt(const long long &val) {
        CUR = val;
    }

    int size() const {
        return v.size();
    }

    bool zero() const {
        return v.empty();
    }

    BigInt &operator=(const BigInt &a) {
        v = a.v;
        return CUR;
    }

    BigInt &operator=(long long val) {
        v.clear();
        while (val) {
            v.push_back(val % BASE);
            val /= BASE;
        }
        return CUR;
    }

    /*****************************compare*****************************/
    bool operator<(const BigInt &a) const {
        if (a.size() != size())
            return size() < a.size();
        for (int i = size() - 1; i >= 0; i--) {
            if (v[i] != a.v[i])
                return v[i] < a.v[i];
        }
        return false;
    }

    bool operator>(const BigInt &a) const {
        return a < CUR;
    }

    bool operator==(const BigInt &a) const {
        return (!(CUR < a) && !(a < CUR));
    }

    bool operator<=(const BigInt &a) const {
        return ((CUR < a) || !(a < CUR));
    }

    /*******************************add*******************************/
    BigInt operator+(const BigInt &a) const {
        BigInt res = CUR;
        int idx = 0, carry = 0;
        while (idx < a.size() || carry) {
            if (idx < a.size())
                carry += a.v[idx];
            if (idx == res.size())
                res.v.push_back(0);
            res.v[idx] += carry;
            carry = res.v[idx] / BASE;
            res.v[idx] %= BASE;
            idx++;
        }
        return res;
    }

    BigInt operator-(const BigInt &a) const {
        BigInt res = CUR;
        int idx = 0, carry = 0;
        while (idx < a.size() || carry) {
            if (idx < a.size())
                carry -= a.v[idx];
            if (idx == res.size())
                res.v.push_back(0);
            res.v[idx] += carry;
            carry = res.v[idx] / BASE;
            res.v[idx] -= carry * BASE;
            while (res.v[idx] < 0) {
                res.v[idx] += BASE;
                carry--;
            }
            idx++;
        }
        return res;
    }

    BigInt &operator+=(const BigInt &a) {
        CUR = CUR + a;
        return CUR;
    }

    /***************************multiply****************************/
    BigInt operator*(const BigInt &a) const {
        BigInt res;
        if (CUR.zero() || a.zero())
            return res;
        res.v.resize(size() + a.size());
        for (int i = 0; i < size(); i++) {
            if (v[i] == 0)
                continue;
            long long carry = 0;
            for (int j = 0; carry || j < a.size(); j++) {
                carry += 1LL * v[i] * (j < a.size() ? a.v[j] : 0);
                while (i + j >= res.size())
                    res.v.push_back(0);
                carry += res.v[i + j];
                res.v[i + j] = carry % BASE;
                carry /= BASE;
            }
        }
        while (!res.v.empty() && res.v.back() == 0)
            res.v.pop_back();
        return res;
    }

    BigInt &operator*=(const BigInt &a) {
        CUR = CUR * a;
        return CUR;
    }

    /*****************************Division****************************/
    BigInt &operator>>=(const int &a) {
        v = v.substr(a);
        return CUR;
    }

    friend ostream &operator<<(ostream &out, const BigInt &a) {
        out << (a.zero() ? 0 : a.v.back());
        for (int i = (int) a.v.size() - 2; i >= 0; i--)
            out << (int) a.v[i];
        return out;
    }

#undef CUR
};

string convert_to_binary(char ch, int len) {
    string res;
    for (int i = 0; i < len; i++) {
        res = char((ch & 1)) + res;
        ch /= 2;
    }
    return res;
}

string convert_to_binary(string s, int bits_per_char) {
    string res;
    for (char ch: s) {
        res += convert_to_binary(ch, bits_per_char);
    }
    return res;
}

string convert_to_binary(int x) {
    string res;
    while (x > 0) {
        res = char(x & 1) + res;
        x >>= 1;
    }
    return res;
}

int main() {
    string s;
    int mod;
    while (cin >> s >> mod) {
        string bin = convert_to_binary(s, 8);
        string binmod = convert_to_binary(mod);


        BigInt MOD(binmod), target(bin);
        BigInt st = 1, ed(bin), ans = 0;
        while (st <= ed) {
            BigInt md = st + ed;
            md >>= 1;
            if (md * MOD <= target) {
                ans = md;
                st = md + 1;
            } else
                ed = md - 1;
        }
        BigInt res = target - ans * MOD;
        int out = 0;
        for (int i = 0; i < res.size(); i++) {
            out += (1 << i) * res.v[i];
        }
        cout << out << endl;
    }
}