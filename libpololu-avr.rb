class LibpololuAvr < Formula
  homepage "https://www.pololu.com/docs/0J20"

  version "151002"
  file_id="0J1058"
  url "https://www.pololu.com/file/download/libpololu-avr-#{version}.zip?file_id=#{file_id}"
  sha256 "206131a5ca094d83917c5c51dc2f99d5278fc13a0bb248e03196b4450902023d"

  depends_on 'avr-gcc'

  def install
    ENV["LIB"] = "#{prefix}/lib"
    ENV["POLOLU_INCLUDE"] = "#{prefix}/include"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-END.undent
      #include <pololu/orangutan.h>

      int main()
      {
        print("Hello!");
        play("L16 ceg>c");

        red_led(1);
        green_led(1);

        return 0;
      }
    END

    system "avr-g++", "test.cpp", "-mmcu=atmega328p",
      "-I#{Formula['avr-gcc'].prefix}/avr/include",
      "-L/usr/local/lib", "-lpololu_atmega328p",
      "-o", "test"
  end
end
