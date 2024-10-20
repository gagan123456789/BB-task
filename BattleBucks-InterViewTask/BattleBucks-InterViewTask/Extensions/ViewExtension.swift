//
//  ViewExtension.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

// Extension on View to show a toast notification
extension View {
    
    // Function to display a toast message
    // - Parameters:
    //   - isPresented: A Binding to control whether the toast is visible
    //   - message: The message to display in the toast
    // - Returns: A modified View that conditionally displays the toast
    func toast(isPresented: Binding<Bool>, message: String) -> some View {
        ZStack {
            // The original view is rendered first
            self
            
            // Conditionally show the toast when isPresented is true
            if isPresented.wrappedValue {
                VStack {
                    Spacer() // Push the toast to the bottom of the screen
                    
                    // Display the toast message
                    Text(message)
                        .padding()
                        .background(Color.black.opacity(0.8)) // Dark background with opacity
                        .foregroundColor(.white) // White text color
                        .cornerRadius(10) // Rounded corners for the toast
                        .padding(.bottom, 50) // Add space from the bottom edge
                        .transition(.opacity) // Fade in/out effect when appearing/disappearing
                        .onAppear {
                            // Automatically hide the toast after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isPresented.wrappedValue = false
                            }
                        }
                }
                // Animate the appearance/disappearance of the toast
                .animation(.easeInOut, value: isPresented.wrappedValue)
            }
        }
    }
}
